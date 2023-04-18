class CreateTeas < ActiveRecord::Migration[7.0]
  def change
    create_table :teas do |t|
      t.string :name
      t.string :type
      t.string :description
      t.string :brew_time
      t.float :price

      t.timestamps
    end
  end
end
