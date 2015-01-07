class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :category
      t.datetime :time

      t.timestamps
    end
  end
end
