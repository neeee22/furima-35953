class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :detail
    validates :images
  end

  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :status_id
    validates :fee_id
    validates :prefecture_id
    validates :schedule_id
  end

  belongs_to :user
  has_one :order
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :fee
  belongs_to :prefecture
  belongs_to :schedule
end
