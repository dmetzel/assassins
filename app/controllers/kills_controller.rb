class KillsController < ApplicationController
  def index
    @kills = Kill.all
  end

  def show
    @kill = Kill.find(params[:id])
  end

  def new
    @kill = Kill.new
    @kill.game_id = params[:id]
    @kill.user_id = current_user.id
    @kill.victim_id = Game.find(params[:id]).enrollments.where({user_id: current_user.id}).first
  end

  def create
    @kill = Kill.new
    @kill.victim_id = params[:victim_id]
    @kill.kill_time = params[:kill_time]
    @kill.kill_story = params[:kill_story]
    @kill.user_id = params[:user_id]
    @kill.game_id = params[:game_id]

    if @kill.save
      redirect_to "/kills", :notice => "Kill created successfully."
    else
      render 'new'
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
end
