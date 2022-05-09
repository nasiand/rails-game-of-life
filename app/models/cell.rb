class Cell < ApplicationRecord
  belongs_to :grid

  def dead?
    !alive
  end

  # def die!
  #   self.update!(alive: false)
  # end

  # def live!
  #   self.update!(alive: true)
  # end
end
