class Staff::IssuesController < Staff::BaseController
  before_filter :find_issue_and_check_perms, :only=>[:show, :edit, :update, :destroy]  



  # GET /issues/1
  # GET /issues/1.json
  def show

    # concatenate all tags into a single editable field

    @issue.tag_string = ""
    @issue.tags.each do |tag|
      @issue.tag_string += tag.tag + ' '
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new

    @issue = Issue.new
    @issue.poller_type = params[:poller_type]
    @issue.poller_id = params[:poller_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    
    # concatenate all the tags into a single string for editing

    @issue.tag_string = ""
    @issue.tags.each do |tag|
      logger.debug "found tag"     
      @issue.tag_string += tag.tag + " "
    end


  end

  # POST /issues
  # POST /issues.json
  def create

    issue_hash = params[:issue]
    raise AccessDenied unless Office::check_staff_permission( issue_hash[:poller_id], current_user.staff_official_id)
    
    issue = Issue.new(issue_hash.except(:poller_type, :poller_id))
    issue.poller_type = issue_hash[:poller_type]
    issue.poller_id = issue_hash[:poller_id]
    
    tags = issue_hash[:tag_string].split(' ')
    tags.each do |tag|
      issue.tags.build( :tag => tag )
    end 

    logger.info "trying to save issue: " + issue.to_s
    respond_to do |format|
      if issue.save!
        disqus_thread_id = createDisqusThread(issue.id, issue.title)
        if (disqus_thread_id)
          issue.disqus_thread_id = disqus_thread_id
          issue.save!
        end
        format.html { redirect_to staff_path, notice: 'Issue was successfully created.' }
        format.json { render json: issue, status: :created, location: @issue }
      else
        logger.info issue.errors.to_s 
        format.html { render action: "new" }
        format.json { render json: issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update

    issue_hash = params[:issue]   
    tags = []
    
    unless params[:issue][:tag_string].nil?
      tags = params[:issue][:tag_string].split(' ')
      @issue.tags.each do |t|
        t.mark_for_destruction
      end
    end
    @issue.save
    unless params[:issue][:tag_string].nil?
      tags.each do |tag|
        @issue.tags.build( :tag => tag )
      end
    end

    respond_to do |format|
      if @issue.update_attributes(issue_hash.except(:poller_type, :poller_id))
        format.html { redirect_to staff_path, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to staff_issues_url }
      format.json { head :no_content }
    end
  end
  
  protected
  

  def find_issue_and_check_perms
    @issue = Issue.find(params[:id])
    if (@issue.poller_type != 'Office')
      raise AccessDenied
    end
    raise AccessDenied unless Office::check_staff_permission( @issue.poller_id, current_user.staff_official_id)
  end
  
  def createDisqusThread(issue_id, title)
    logger.info "new issue calling disqus to create a thread"
    response = DisqusAPI.threadCreate(DisqusAPI::ISSUES_FORUM,title,{:identifier => issue_id.to_s })
    if (!response[:exception])
      if (response[:http_response_code] == 200)
        thread_id = response[:thread][:id]
        logger.info "new issue created disqus thread #{thread_id}"
        return thread_id
      else
        logger.info "new issue got http response code #{response[:http_response_code]}"
        return nil
      end
    else
      return nil
    end    
  end
  
end
