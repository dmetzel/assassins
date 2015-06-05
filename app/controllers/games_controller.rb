class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])

    this_enroll = Enrollment.where({user_id: current_user.id, game_id: @game.id}).first
    dead = true
    confirmed = true
    i = this_enroll.user_order + 1
    while dead && confirmed
    next_enroll = Enrollment.where({user_order: i, game_id: @game.id}).first
    dead = next_enroll.dead
    if dead
      confirmed = next_enroll.confirmed
    end
    i += 1
    if Enrollment.where({user_order: i, game_id: @game.id}).first == nil
      i = 0
    end
  end

    if next_enroll.user == current_user
      @target = "YOU WON!"
    else
    @target = next_enroll.user.first_name + " " + next_enroll.user.last_name
    if !confirmed
      @target += "<br>(your kill has been recorded but is awaiting confirmation by your victim)"
    end
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

  def destroy
    @game = Game.find(params[:id])

    @game.destroy

    redirect_to "/games", :notice => "Game deleted."
  end
end
