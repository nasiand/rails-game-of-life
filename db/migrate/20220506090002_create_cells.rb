class CreateCells < ActiveRecord::Migration[6.1]
  def change
    create_table :cells do |t|
      t.boolean :alive, default: false, null: false
      t.integer :row_position, null: false
      t.integer :column_position, null: false
      t.references :grid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
