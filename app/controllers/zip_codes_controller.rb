class ZipCodesController < ApplicationController

  # GET /zip_codes
  # GET /zip_codes.json
  
  def index

    @zip_codes = ZipCode.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @zip_codes }
    end
  end

  # GET zip_codes/98121
  # GET zip_codes/98121.json

  def show
  
    @zip_code = ZipCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @zip_code }
    end
  end


end