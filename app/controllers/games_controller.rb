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
    # @grid = @game.grids.find_by(generation: @game.grids.maximum(:generation))
    # @cells = @grid.cells.order(:row_position, :column_position)
  end

  def start
    # TODO: run the game (algorithm)
    # UPDATE the grid of the game
    # Repeat the process untill the are no more generation to change
    @game = Game.find(params[:id])
    @game.start
    redirect_to @game
  end

  private

  def game_params
    params.require(:game).permit(:file)
  end
end
