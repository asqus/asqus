class PostalCitiesController < ApplicationController

  # GET /states/1/postal_cities.json
  # GET /states/1/postal_cities.json
  def index

    state_id = params[:state_id]

    @state = State.find( state_id )
    @cities = PostalCity.where( :state_id => state_id )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities }
    end
  end

  # GET /states/1/postal_cities/1
  # GET /states/1/postal_cities/1.json
  def show
  
    @city = PostalCity.find(params[:state_id],params[:name])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @city }
    end
  end


end