class Cell < ApplicationRecord
  belongs_to :grid

  def dead?
    !alive
  end
end
