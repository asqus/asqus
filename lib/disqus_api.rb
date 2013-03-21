module DisqusAPI

  BASE_URL = 'https://disqus.com/api/3.0'
  API_SECRET = PRIVATE_CONFIG['disqus']['api_secret'] 
  ACCESS_TOKEN = PRIVATE_CONFIG['disqus']['access_token']
  ISSUES_FORUM = PRIVATE_CONFIG['disqus']['issues_forum']
  SOCKET_ERROR = 'SocketError'

 
  def self.threadCreate(forum,title,options)
    url = BASE_URL + "/threads/create.json"
    query = {:forum => forum, :title => title, :api_secret => API_SECRET, :access_token => ACCESS_TOKEN }
    begin
      query = query.merge(options)
      Rails.logger.info "query: " + query.to_s
      response = HTTParty.post(url, :query => query )
    rescue SocketError
      return {:exception => SOCKET_ERROR}
    end
    Rails.logger.info "reponse: " + response.body.to_s
    thread = nil
    return_code = nil
    if (response.code == 200)
      parsed_response = JSON.parse(response.body).to_hash.with_indifferent_access
      thread = parsed_response[:response]
      return_code = parsed_response[:code]
    end
    return {:http_response_code => response.code, :return_code => return_code, :thread => thread}
  end
  
  
  def self.threadOpen(forum, id)
    url = BASE_URL + "/threads/open.json"
    begin
      response = HTTParty.post(url, :query =>{:forum => forum, :id => id, :api_secret => API_SECRET, :access_token => ACCESS_TOKEN} )
    rescue SocketError
      return {:exception => SOCKET_ERROR}
    end
    resp = nil
    return_code = nil
    if (response.code == 200)
      parsed_reponse = JSON.parse(response.body).to_hash.with_indifferent_access
      resp = parsed_response[:response]
      return_code = parsed_response[:code]
    end
    return {:http_response_code => response.code, :return_code => return_code, :response => resp }
  end
      
  
  def self.forumListPosts(id)
    url = BASE_URL + "/forums/listPosts.json"
    parms = {:forum => id, :api_secret => API_SECRET} 
    exception = nil 
    begin      
      response = HTTParty.get(url, :query => parms)
    rescue SocketError
      return {:exception => SOCKET_ERROR}
    end
    posts = [] 
    if (response.code == 200)
      parsed_response = JSON.parse(response.body).to_hash.with_indifferent_access
      posts = parsed_response[:response]
    end
    return {:http_response_code => response.code, :return_code => parsed_response[:code], :posts => posts}
  end
  
  
  # sample code for calling forumListThreads
  # @disq = DisqusAPI.forumListThreads(DisqusAPI::ISSUES_FORUM)
  # if (!@disq[:exception])
  #   disq_posts = @disq[:threads]
  #   disq_http_response_code = @disq[:http_response_code]
  #   disq_return_code = @disq[:return_code]
  #   if (disq_http_response_code == 200)
  #     disq_posts.each do |p|
  #       logger.info "resp: " + p.to_s     
  #     end
  #   end
  # else
  #   logger.info 'disqus exception: ' + @disq[:exception]
  # end
  
  
  def self.forumListThreads(id)
    url = BASE_URL + "/threads/list.json"
    parms = {:forum => id, :api_secret => API_SECRET}
    begin
      response = HTTParty.get(url, :query => parms)
    rescue SocketError
      return {:exception => SOCKET_ERROR}
    end
    threads = []
    if (response.code == 200)
      parsed_response = JSON.parse(response.body).to_hash.with_indifferent_access
      threads = parsed_response[:response]
    end
    return {:http_response_code => response.code, :return_code => parsed_response[:code], :threads => threads}
  end
      
      
  def self.postCreate(message)
    url = BASE_URL + "/posts/create.json"
    HTTParty.post(url, :body => message.merge({:api_secret => API_SECRET}))
  end
  
 
  
end 
