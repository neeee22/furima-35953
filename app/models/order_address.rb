class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code,
                :prefecture,
                :city,
                :number,
                :building_name,
                :phone_number,
                :order_id,
                :user_id,
                :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :number
    validates :phone_number
    validates :user_id
  end
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    order = Order.create()
  end
end