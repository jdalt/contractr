class JobsController < ApplicationController

  def new
    @job = Job.new( name: "Fake Name")
    3.times do |i|
      logger.info "#{i} item built"
      item = @job.work_items.new
      logger.debug(item.inspect)
    end
  end

  def create
    #TODO: redo this so that we create a job first,
    # and then create the ids for the work_items
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

  # def show
  # end

end
