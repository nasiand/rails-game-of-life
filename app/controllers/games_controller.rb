class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.user = current_user

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

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    redirect_to new_game_path
  end

  private

  def game_params
    params.require(:game).permit(:file)
  end
end
