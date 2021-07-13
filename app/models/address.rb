class Address < ApplicationRecord
  with_options presence: true do
    validates :postal_code
    validates :city
    validates :number
    validates :phone_number
  end

  validates :prefecture_id, numericality: { other_than: 1 }

  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
