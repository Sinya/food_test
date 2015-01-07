class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.references :user, index: true
      t.string :name
      t.string :category
      t.integer :user_id
      t.date :due

      t.timestamps
    end
  end
end
