class JobsController < ApplicationController

  def new
    @job = Job.new
    @first_work_item = @job.work_items.new
  end

  def create
  end

  def show
  end

end
