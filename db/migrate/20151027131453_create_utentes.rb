class CreateUtentes < ActiveRecord::Migration
  def change
    create_table :utentes do |t|
      t.string :user
      t.string :password
      t.integer :record1
      t.integer :record2
      t.integer :record3

      t.timestamps null: false
    end
  end
end
