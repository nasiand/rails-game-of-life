class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    if @game.save
      @game.make_grid_from_file
      redirect_to @game
    else
      render :new
    end
  end

  def show
    @game = Game.includes(grids: :cells).find(params[:id])
  end

  def start
    @game = Game.find(params[:id])
    @game.start
    redirect_to @game
  end

  private

  def game_params
    params.require(:game).permit(:file)
  end
end
