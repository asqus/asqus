class QuickPollResultsController < ApplicationController


  # GET /quick_poll_results/1
  # GET /quick_poll_results/1.json
  def show
    
    # todo: replace this demo data
    
    @quick_poll = QuickPoll.find(params[:id])
    quick_poll_id = @quick_poll.id
    
    # todo: for some reason I the fucking exec_query won't accept the binds parameter without
    # a syntax error, so fix that fucking shit or else sanitize the fucking quick_poll_id variable
    # fucking fuck
    
    @results = ActiveRecord::Base.connection.exec_query(
       "select text as name, value, sum(count), 0 as percentage from ( 
           select 
               o.text, r.value as value, count(*) as count
           from
              quick_poll_responses r,
              quick_poll_options o
           where
               r.quick_poll_id = o.quick_poll_id and
               r.value = o.value and
               r.quick_poll_id = #{quick_poll_id}
           group by 
               o.text, r.value
           union
           select 
               o.text, r.value as value, count(*) as count
           from
               quick_poll_unregistered_responses r,
               quick_poll_options o
           where
               r.quick_poll_id = o.quick_poll_id and
               r.value = o.value and
               r.quick_poll_id = #{quick_poll_id}               
           group by 
               o.text, r.value) blargh
       group by name, value" )
  
    
    total_responses = 0    
    @results.each do |result|
       total_responses += result['sum'].to_i 
       logger.info "total responses: " + total_responses.to_s
    end
    
    responses = []
    @results.each do |result|
      r = {}
      r[:name] = result['name']
      r[:sum] = result['sum']
      r[:value] = result['value']
      if (total_responses > 0)
        r[:percentage] = ((result['sum'].to_f / total_responses.to_f) * 100).round(2).to_s
      else
        r[:percentage] = 0
      end
      responses.push r
    end
        
    logger.info "responses ===========> " + responses.to_s
    
    @response = { :poll => @quick_poll, :results => responses }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response }
    end
  end
end
