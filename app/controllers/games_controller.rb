class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
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

  def destroy
    @game = Game.find(params[:id])

    @game.destroy

    redirect_to "/games", :notice => "Game deleted."
  end
end
