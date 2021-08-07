class Brand < ApplicationRecord
  has_many :item_brand_relations
  has_many :items, through: :item_brand_relations

  validates :brand_name, uniqueness: true
end
