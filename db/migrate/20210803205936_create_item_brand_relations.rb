class CreateItemBrandRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :item_brand_relations do |t|
      t.references :item, foreign_key: true
      t.references :brand, foreign_key: true
      t.timestamps
    end
  end
end
