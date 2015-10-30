class CreateUtentes < ActiveRecord::Migration
  def change
    create_table :utentes do |t|
      t.string :user
      t.string :password
      t.string :record1
      t.string :record2
      t.string :record3

      t.timestamps null: false
    end
  end
end
