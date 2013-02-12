class QuickPollResponsesController < ApplicationController
  # GET /quick_poll_responses
  # GET /quick_poll_responses.json
  def index

    @quick_poll = QuickPoll.find(params[:quick_poll_id])
    @quick_poll_responses = QuickPollResponse.where(:quick_poll_id => params[:quick_poll_id])

    if @quick_poll.issue.poller_type == 'Office'
      @jot = JoinedOfficialTerm.find_by_office_id(@quick_poll.issue.poller_id)
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
    if (current_user)
      response[:user_id] = current_user.id
      quick_poll_response = QuickPollResponse.new(response)
      quick_poll_response.save
    else
      response[:uid] = get_poll_uid()      
      if (QuickPollUnregisteredResponse.where("quick_poll_id = ? and uid = ?", response[:quick_poll_id], response[:uid]).first == nil)
        qp_unregistered_response = QuickPollUnregisteredResponse.new(response)
        qp_unregistered_response.save
      end        
    end

    redirect_to :action => :index, :quick_poll_id => response[:quick_poll_id]
  end





end