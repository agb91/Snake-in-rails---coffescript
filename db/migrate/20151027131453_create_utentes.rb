class CreateUtentes < ActiveRecord::Migration
  def change
    create_table :utentes do |t|
      t.string :user
      t.string :password

      t.timestamps null: false
    end
  end
end
