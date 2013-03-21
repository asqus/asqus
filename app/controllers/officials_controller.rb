class OfficialsController < ApplicationController

  # GET /officials/1
  # GET /officials/1.json
  def show
    @official = Official.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @official }
    end
  end

end
