class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :user_id
      t.date :due
      t.string :category

      t.timestamps
    end
  end
end
