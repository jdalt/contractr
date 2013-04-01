class JobsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @client = Client.new( name: "New Client")
    @job = Job.new( name: "New Job")
    @job.work_items.new
  end

  def create
    @client = current_user.clients.new(params[:client])
    @job = current_user.jobs.new(params[:job])
    @job.client = @client
    if(@client.valid?)
      if(@job.save)
        redirect_to user_job_path(current_user, @job)
      else
        render 'new'
      end
    else
      @job.valid?
      render 'new'
    end
  end

  def update
    logger.debug(params.inspect)
  end

  def show
    @job = current_user.jobs.find(params[:id])
  end

  def index
    @jobs = current_user.jobs.all #paginate this shit later
  end

end
