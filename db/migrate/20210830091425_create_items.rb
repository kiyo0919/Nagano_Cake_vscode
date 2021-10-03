class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_id
      t.string :description
      t.integer :price_without_tax
      t.boolean :is_sale
      t.integer :genre_id

      t.timestamps
    end
  end
end
