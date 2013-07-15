class Admin::DelayedJobsController < Admin::BaseController

  # GET /admin/delayed_jobs
  # GET /admin/delayed_jobs.json
  def index
    @delayed_jobs = DelayedJob.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_delayed_jobs }
    end
  end

  # GET /admin/delayed_jobs/1
  # GET /admin/delayed_jobs/1.json
  def show
    @delayed_job = DelayedJob.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delayed_job }
    end
  end

  # GET /admin/delayed_jobs/1/edit
  def edit
    @delayed_job = DelayedJob.find(params[:id])
  end


end
