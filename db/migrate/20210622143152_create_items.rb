class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,            null: false
      t.string :price,           null: false
      t.text   :detail
      t.string :category,        null: false
      t.string :status,          null: false
      t.string :delivery_charge, null: false
      t.string :shipment_source, null: false
      t.string :shipping_date,   null: false
      
#      t.references :user, null:false, foreign_key: true
      t.timestamps
    end
  end
end
