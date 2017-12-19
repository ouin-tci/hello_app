class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.belongs_to :order, index: true
      t.references :good, index: true
      t.date :order_time
      t.integer :quantity
      t.integer :purchase_price
      t.integer :selling_price
      t.string :order_status

      t.timestamps
    end
  end
end
