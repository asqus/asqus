class MunicipalitiesController < ApplicationController

  # GET /states/1/municipalities
  # GET /states/1/municipalities.json
  def index

    state_id = params[:state_id]

    @state = State.find( state_id )
    @municipalities = Municipality.where( :state_id => state_id )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @municipalities }
    end
  end

  # GET /states/1/municipalities/1
  # GET /states/1/municipalities/1.json
  def show
  
    @municipality = Municipality.find(params[:state_id],params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @municipality }
    end
  end


end
