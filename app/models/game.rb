class Game < ApplicationRecord
  belongs_to :user
  has_many :grids, dependent: :destroy
  has_one_attached :file

  validate :file_content_type

  def start
    while true do      
      changed = false
      # create a new 2D Array because I need to not change the value of the actual cells
      max_generation = self.grids.maximum(:generation)
      actual_grid = self.grids.find_by(generation: max_generation)
      next_grid = self.grids.new(generation: max_generation + 1, rows: actual_grid.rows, cols: actual_grid.cols)
      next_grid.save
      # I need to order the cells becasue I don't have the garanty that the DB has already ordered by ID of inserction
      actual_grid.cells.order(:row_position, :column_position).each do |cell|
        # count live neighbors
        neighbors = actual_grid.count_neighbors(cell)
        new_cell = cell.dup # full copy (copying the value, not the reference)
        new_cell.grid = next_grid
        new_cell.save
        # change the state of the cell based on the number of neighbors
        if cell.dead? && neighbors == 3
          new_cell.alive = true
          new_cell.save
          changed = true
        elsif cell.alive? && (neighbors < 2 || neighbors > 3)
          new_cell.alive = false
          new_cell.save
          changed = true
        end
      end
      if changed == false
        next_grid.destroy
        break
      end
    end
  end

  def make_grid_from_file
    # read from the input file. loop through every row of the file
    txt_file = self.file.download.delete(' ')  # returns the content of the file as a string
    grid = self.grids.new
    txt_file.each_line.with_index do |line, row_index| 
      next line if row_index == 0

      if row_index == 1
        grid = self.grids.create(generation: 0, rows: line[0].to_i, cols: line[1].to_i)
        next line
      end
      line = line.chomp.chars # because the last chars is "\n"
      line.each_with_index do |cell, column_index|
        grid.cells.create(alive: cell == "*", row_position: row_index - 2, column_position: column_index)
      end
    end
  end

  private

  def file_content_type
    errors.add(:file, "file type must be .txt") if self.file.blob.content_type != "text/plain"
  end
end
