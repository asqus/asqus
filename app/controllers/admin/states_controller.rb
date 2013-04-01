class Admin::StatesController < Admin::BaseController
  
  # GET /states
  # GET /states.json
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
    
    @states = State.find(:all)
    @state = State.find(params[:id], :include => [ { :offices => :office_type }, {:offices => :incumbents }])
    @us_senator_offices = []
    @us_rep_offices = []
    @state_senator_offices = []
    @state_rep_offices = []
    @state.offices.each do |o|
      case o.office_type.ukey
        when 'US_SENATOR'
          @us_senator_offices.push(o)
        when 'US_REP'
          @us_rep_offices.push(o)
        when 'HOUSE_DELEGATE'
          @us_rep_offices.push(o)
        when 'STATE_SENATOR'
          @state_senator_offices.push(o)
        when 'STATE_REP'
          @state_rep_offices.push(o)
      end
    end
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @state }
    end
  end

  # GET /states/1/edit
  def edit
    @state = State.find(params[:id])
  end

  # PUT /states/1
  # PUT /states/1.json
  def update
    @state = State.find(params[:id])

    respond_to do |format|
      if @state.update_attributes(params[:state])
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

end
