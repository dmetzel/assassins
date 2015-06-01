class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new
    @enrollment.killed_by = params[:killed_by]
    @enrollment.dead = params[:dead]
    @enrollment.autokilled = params[:autokilled]
    @enrollment.confirmed = params[:confirmed]
    @enrollment.game_id = params[:game_id]
    @enrollment.user_order = params[:user_order]
    @enrollment.kill_time = params[:kill_time]
    @enrollment.alias = params[:alias]
    @enrollment.user_id = params[:user_id]

    if @enrollment.save
      redirect_to "/enrollments", :notice => "Enrollment created successfully."
    else
      render 'new'
    end
  end

  def edit
    @enrollment = Enrollment.find(params[:id])
  end

  def update
    @enrollment = Enrollment.find(params[:id])

    @enrollment.killed_by = params[:killed_by]
    @enrollment.dead = params[:dead]
    @enrollment.autokilled = params[:autokilled]
    @enrollment.confirmed = params[:confirmed]
    @enrollment.game_id = params[:game_id]
    @enrollment.user_order = params[:user_order]
    @enrollment.kill_time = params[:kill_time]
    @enrollment.alias = params[:alias]
    @enrollment.user_id = params[:user_id]

    if @enrollment.save
      redirect_to "/enrollments", :notice => "Enrollment updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])

    @enrollment.destroy

    redirect_to "/enrollments", :notice => "Enrollment deleted."
  end
end
