class StatesController < ApplicationController
  def index
    
    @states = State.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @states }
    end
  end


  # GET /states/1
  # GET /states/1.json
  
  def show
    @state = State.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @state }
    end
  end

end
