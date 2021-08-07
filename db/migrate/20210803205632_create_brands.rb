class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :brand_name, null:false, uniqueness: true
      t.timestamps
    end
  end
end
