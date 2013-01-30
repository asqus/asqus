class QuickPollResultsController < ApplicationController


  # GET /quick_poll_results/1
  # GET /quick_poll_results/1.json
  def show
    
    # todo: replace this demo data
    
    @quick_poll = QuickPoll.find(params[:id])
    @results = [ { :name => "Agree Strongly", :value => 1, :count => 231}, 
                 { :name => "Agree Somewhat", :value => 2, :count => 342},
                 { :name => "Neutral/Undecided", :value => 3, :count => 453},
                 { :name => "Disagree Somewhat", :value => 4, :count => 676},
                 { :name => "Disagree Strongly", :value => 5, :count => 301} ]

    @response = { :poll => @quick_poll, :results => @results }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response }
    end
  end
end
