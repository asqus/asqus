class Staff::OfficialMailingsController < ApplicationController

  # GET /official_mailings
  # GET /official_mailings.json
  
  def index

    @official = Official.find(current_user.staff_official_id)
    @mailings = OfficialMailing.where( :official_id => @official.id ).order("id desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mailings }
    end
  end

  # GET /official_mailings/1
  # GET /official_mailings/1.json
  
  def show

    @mailing = OfficialMailing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mailing }
    end
  end


  # GET /official_mailings/new
  # GET /official_mailings/new.json

  def new

    @mailing = OfficialMailing.new
    @mailing.official_id = current_user.staff_official_id
    @polls = QuickPoll::get_unnotified_polls_for_official(current_user.staff_official_id)
           
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mailing }
    end
  end
  
  
  # POST /official_mailings
  # POST /official_mailings.json


  def create
        
    success = false
    
    OfficialMailing.transaction do
      
      mailing = OfficialMailing.new
      mailing.official_id = current_user.staff_official_id
      logger.debug params[:official_mailing].to_s
      mailing.rep_message = params[:official_mailing][:rep_message]
      mailing.mailing_status_id = MailingStatus::READY.id
      
      polls = QuickPoll::get_unnotified_polls_for_official(current_user.staff_official_id)
      
      if (polls.length > 0)
        polls.each do |poll|
          mailing.quick_polls.push(poll)
        end      
        success = mailing.save      
        mailing.delay.send_notifications
      end
      
    end
    
    respond_to do |format|
      if success
        format.html { redirect_to staff_official_mailings_url, notice: 'Mailing created.' }
        format.json { render json: mailing, status: :created, location: mailing }
      else
        format.html { render action: "new" }
        format.json { render json: mailing.errors, status: :unprocessable_entity }
      end
    end

  end



  
  
end
