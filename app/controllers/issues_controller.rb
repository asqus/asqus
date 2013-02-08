class IssuesController < ApplicationController
  # GET /issues
  # GET /issues.json
  def index

    @poller = eval(params[:poller_type]).find(params[:poller_id])    
    @issues = Issue.where( :poller_type => params[:poller_type], :poller_id => params[:poller_id] );

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show

    @issue = Issue.find(params[:id])

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
    @issue = Issue.find(params[:id])

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

    logger.debug issue_hash

    logger.info "new issue: " + issue_hash.to_s
    @issue = Issue.new(issue_hash)

    tags = issue_hash[:tag_string].split(' ')
    tags.each do |tag|
      @issue.tags.build( :tag => tag )
    end 

    logger.info "trying to save issue: " + @issue.to_s
    respond_to do |format|
      if @issue.save!
        logger.info "saving issue " + @issue.to_s
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        logger.info @issue.errors.to_s 
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
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
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end
end
