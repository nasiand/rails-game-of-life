class CreateGrids < ActiveRecord::Migration[6.1]
  def change
    create_table :grids do |t|
      t.integer :generation
      t.integer :rows
      t.integer :cols
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
