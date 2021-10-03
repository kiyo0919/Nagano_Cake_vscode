class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :end_user_id
      t.integer :postage, default: 800
      t.integer :total_price
      t.integer :payment_method, default: 0
      t.string :address
      t.string :postal_code
      t.string :name
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end
