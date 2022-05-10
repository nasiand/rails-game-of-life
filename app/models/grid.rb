class Grid < ApplicationRecord
  belongs_to :game
  has_many :cells, dependent: :destroy

  def count_neighbors(cell)
    sum = 0
    (-1..1).each do |row_offset|
      (-1..1).each do |column_offset|
        # row_offset and column_offset are offset relative from where I'm looking (in the 8 neighbors)
        i = (row_offset + cell.row_position).abs
        j = (column_offset + cell.column_position).abs
        i = 0 unless i < self.rows
        j = 0 unless j < self.cols
        if self.cells.find_by(row_position: i, column_position: j).alive?
          next if i == cell.row_position && j == cell.column_position

          sum += 1
        end
      end
    end
    sum
  end
end
