class QuickPollResultsController < ApplicationController


  # GET /quick_poll_results/1
  # GET /quick_poll_results/1.json
  def show
    
    # todo: replace this demo data
    
    @quick_poll = QuickPoll.find(params[:id])

    @results = QuickPollResponse.find_by_sql([
                "select 
                   o.text as name, r.value as value, count(*) as count
                 from
                   quick_poll_responses r,
                   quick_poll_options o
                 where
                   r.quick_poll_id = o.quick_poll_id and
                   r.value = o.value and
                   r.quick_poll_id = ?
                 group by 
                   o.text, r.value
                 ", params[:id]])
    
  
    
    @response = { :poll => @quick_poll, :results => @results }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response }
    end
  end
end
