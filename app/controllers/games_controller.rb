class GamesController < ApplicationController
  def index
    @games = current_user.games
    @games += Game.where({gamemaster_id: current_user.id})
    @games = @games.uniq

  end

  def show
    @game = Game.find(params[:id])

    if current_user.games.include?(@game)
      @status, @target = current_target(@game,current_user)
    end

  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.title = params[:title]
    @game.description = params[:description]
    @game.rules = params[:rules]
    @game.start_time = params[:start_time]
    @game.kill_window = params[:kill_window]
    @game.gamemaster_id = params[:gamemaster_id]
    @game.time_zone = params[:time_zone]

    if @game.save
      redirect_to "/games", :notice => "Game created successfully."
    else
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])

    @game.title = params[:title]
    @game.description = params[:description]
    @game.rules = params[:rules]
    @game.start_time = params[:start_time]
    @game.kill_window = params[:kill_window]
    @game.gamemaster_id = params[:gamemaster_id]
    @game.time_zone = params[:time_zone]

    if @game.save
      redirect_to "/games", :notice => "Game updated successfully."
    else
      render 'edit'
    end
  end

  def delete
    @game = Game.find(params[:id])
  end

  def destroy
    @game = Game.find(params[:id])
    @game.enrollments.each do |i|
      i.destroy
    end
    @game.kills.each do |i|
      i.destroy
    end
    @game.destroy

    redirect_to "/games", :notice => "Game deleted."
  end
end
