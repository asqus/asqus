class QuickPollResponsesController < ApplicationController
  # GET /quick_poll_responses
  # GET /quick_poll_responses.json
  def index

    @quick_poll = QuickPoll.find(params[:quick_poll_id])
    @quick_poll_responses = QuickPollResponse.where(:quick_poll_id => params[:quick_poll_id])
    @disqus_forum = PRIVATE_CONFIG['disqus']['issues_forum']
    @user_is_issue_admin = false
    
    if @quick_poll.issue.poller_type == 'Office'
      @jot = JoinedOfficialTerm.find_by_office_id(@quick_poll.issue.poller_id)
      unless current_user.nil?
        @user_is_issue_admin = Office::check_staff_permission( @quick_poll.issue.poller_id, current_user.staff_official_id)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quick_poll_responses }
    end
  end

  # GET /quick_poll_responses/1
  # GET /quick_poll_responses/1.json
  def show
    @quick_poll_response = QuickPollResponse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quick_poll_response }
    end
  end

  # GET /quick_poll_responses/new
  # GET /quick_poll_responses/new.json
  def new

    @quick_poll_response = QuickPollResponse.new
    @quick_poll = QuickPoll.find(params[:quick_poll_id])
    
    max_len = 0
    @quick_poll.quick_poll_options.each do |o|
      logger.info( "o.text = (%s) %s " % [ o.text.length, o.text ] )
      if o.text.length > max_len
         max_len = o.text.length
      end
    end
    
    # Approximately 33.33 pixs per chars looks good.   
    logger.info( "Hello Robbie Dob!" )
    @quick_poll_options_width_px =  max_len * 33.33
    logger.info( "@quick_poll_options_width_px = %s" % [ @quick_poll_options_width_px ] )
    

    logger.info( "Hello Robbie Dob! %s" % [ @quick_poll.quick_poll_options.length ] )

    max_len = 0
    @quick_poll.quick_poll_options.each do |o|
      logger.info( "o.text = (%s) %s " % [ o.text.length, o.text ] )
      if o.text.length > max_len
         max_len = o.text.length
      end
    end
    
    # Approximately 33.33 pixs per chars looks good.   
    @quick_poll_options_width_px =  40.0 + max_len * 10.0
    logger.info( "@quick_poll_options_width_px = %s" % [ @quick_poll_options_width_px ] )

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quick_poll_response }
    end
  end

  # GET /quick_poll_responses/1/edit
  def edit
    @quick_poll_response = QuickPollResponse.find(params[:id])
  end

  # POST /quick_poll_responses
  # POST /quick_poll_responses.json

  def create

    response = params[:quick_poll_response]
    quick_poll_id = response[:quick_poll_id]
    browser_fingerprint = response[:browser_fingerprint]
    
    logger.info("browser fingerprint = " + browser_fingerprint)
    
    options = QuickPollOption.find_all_by_quick_poll_id(quick_poll_id)
    value = nil
    options.each do |option|
      if params[option.value.to_s]
        value = option.value
      end
    end
    
    if (value)
      response[:value] = value
      if (current_user)
        response[:user_id] = current_user.id
        quick_poll_response = QuickPollResponse.new(response)
        quick_poll_response.save
        # User.delay.send_thanks_for_voting_email(current_user.id)
        User.send_thanks_for_voting_email(current_user.id)
        current_user.post_to_facebook_wall(current_user.first_name + " voted in an Asq.us poll")
      else
        response[:uid] = get_poll_uid()      
        if (QuickPollUnregisteredResponse.where("quick_poll_id = ? and browser_fingerprint = ?", response[:quick_poll_id], response[:browser_fingerprint]).first == nil)
          qp_unregistered_response = QuickPollUnregisteredResponse.new(response)
          qp_unregistered_response.save
        end        
      end
    end

    redirect_to :action => :index, :quick_poll_id => response[:quick_poll_id]
  end





end
