class CreateLabirintos < ActiveRecord::Migration
  def change
    create_table :labirintos do |t|
      t.string :livello
      t.string :xstart
      t.string :ystart
      t.string :direction
      t.string :length
      t.timestamps null: false
    end
  end
end
