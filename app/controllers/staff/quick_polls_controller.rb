class Staff::QuickPollsController < Staff::BaseController
  before_filter :find_quick_poll_and_check_perms, :only=>[:show, :edit, :update, :destroy]  
    
  # GET /staff/quick_polls/1
  # GET /staff/quick_polls/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quick_poll }
    end
  end

  # GET /staff/quick_polls/new
  # GET /staff/quick_polls/new.json
  def new

    @quick_poll = QuickPoll.new
    @poller_type = params[:poller_type]
    @poller_id = params[:poller_id]
    
    @issues = Issue.where( :poller_type => @poller_type, :poller_id => @poller_id )

    5.times { @quick_poll.quick_poll_options.build }
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quick_poll }
    end
  end

  # GET /staff/quick_polls/1/edit
  def edit

    @poller_type = @quick_poll.issue.poller_type
    @poller_id = @quick_poll.issue.poller_id
    @issues = Issue.where( :poller_type => @poller_type, :poller_id => @poller_id )

  end

  # POST /staff/quick_polls
  # POST /staff/quick_polls.json
  def create

    qp = params[:quick_poll]
    issue = Issue.find(qp[:issue_id])
    raise AccessDenied unless Office::check_staff_permission(issue.poller_id, current_user.staff_official_id)    
    qp[:poll_workflow_state_id] = PollWorkflowState::PUBLISHED.id
    @quick_poll = QuickPoll.new(qp)

    respond_to do |format|
      if @quick_poll.save
        format.html { redirect_to staff_quick_poll_path(@quick_poll), notice: 'Quick poll was successfully created.' }
        format.json { render json: @quick_poll, status: :created, location: @quick_poll }
      else
        logger.debug @quick_poll.errors.full_messages
        @poller_type = params[:quick_poll][:poller_type]
        @poller_id = params[:quick_poll][:poller_id]
        @issues = Issue.where( :poller_type => @poller_type, :poller_id => @poller_id )
        format.html { render action: "new" }
        format.json { render json: @quick_poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /staff/quick_polls/1
  # PUT /staff/quick_polls/1.json
  def update

    qp = params[:quick_poll]
    qp[:poll_workflow_state_id] = 1
    
    respond_to do |format|
      if @quick_poll.update_attributes(params[:quick_poll])
        format.html { redirect_to staff_quick_poll_path(@quick_poll), notice: 'Quick poll was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quick_poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staff/quick_polls/1
  # DELETE /staff/quick_polls/1.json
  def destroy

    @quick_poll.destroy

    respond_to do |format|
      format.html { redirect_to staff_quick_polls_url }
      format.json { head :no_content }
    end
  end
  
  
  def find_quick_poll_and_check_perms
    @quick_poll = QuickPoll.find(params[:id])
    if (@quick_poll.issue.poller_type != 'Office')
      raise AccessDenied
    end
    raise AccessDenied unless Office::check_staff_permission( @quick_poll.issue.poller_id, current_user.staff_official_id)
  end

  
end
