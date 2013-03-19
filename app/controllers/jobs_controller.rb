class JobsController < ApplicationController

  def new
    @job = Job.new( name: "New Job")
    3.times do |i|
      logger.info "#{i} item built"
      item = @job.work_items.new
      logger.debug(item.inspect)
    end
  end

  def create
    @job = Job.new(params[:job])
    if(@job.save)
      redirect_to @job
    else
      render 'new'
    end
  end

  def update
    logger.debug(params.inspect)
  end

  def show
    @job = Job.find(params[:id])
  end

  def index
    @jobs = Job.all #paginate this shit later
  end

end
