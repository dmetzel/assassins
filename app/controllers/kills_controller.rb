class KillsController < ApplicationController
  def index
    @kills = Kill.all
  end

  def show
    @kill = Kill.find(params[:id])
  end

  def new
    @kill = Kill.new
    @kill.game_id = params[:game_id]
    @kill.victim_id = params[:victim_id]
  end

  def create
    @kill = Kill.new
    @kill.victim_id = params[:victim_id]
    @kill.kill_time = params[:kill_time]
    @kill.kill_story = params[:kill_story]
    @kill.user_id = current_user.id
    @kill.game_id = params[:game_id]

    if @kill.save
      enroll = Enrollment.where({user_id: @kill.victim_id, game_id: @kill.game_id}).first
      enroll.dead = true
      enroll.killed_by = current_user.id
      enroll.kill_time = @kill.kill_time
      enroll.save
      redirect_to "/games", :notice => "Kill successfully recorded! Awaiting confirmation by your victim."
    else
      redirect_to "/games", :notice => "Kill was not recorded. Please try again."
    end
  end

  def edit
    @kill = Kill.find(params[:id])
  end

  def update
    @kill = Kill.find(params[:id])

    @kill.victim_id = params[:victim_id]
    @kill.kill_time = params[:kill_time]
    @kill.kill_story = params[:kill_story]
    @kill.user_id = params[:user_id]
    @kill.game_id = params[:game_id]

    if @kill.save
      redirect_to "/kills", :notice => "Kill updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @kill = Kill.find(params[:id])

    @kill.destroy

    redirect_to "/kills", :notice => "Kill deleted."
  end

  def confirm

  end
end
