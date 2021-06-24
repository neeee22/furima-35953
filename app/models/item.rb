class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :price
    validates :detail
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :prefectue_id
    validates :shipping_date_id
  end

  belongs_to :user
  has_one_attached :image
end
