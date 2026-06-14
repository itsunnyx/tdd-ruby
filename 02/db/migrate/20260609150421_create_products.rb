class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :slug

      t.timestamps
    end
  end
end
