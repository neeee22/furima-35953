class ItemBrand
  include ActiveModel::Model
  attr_accessor :name, :detail, :images, :category_id, :status_id, :fee_id, :prefecture_id, :schedule_id, :price, :user_id,:brand_name

  with_options presence: true do
    validates :name
    validates :detail
    validates :images
  end

  validates :brand_name, presence: true

  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  with_options numericality: { other_than: 0, message: 'を選択してください' } do
    validates :category_id
    validates :status_id
    validates :fee_id
    validates :prefecture_id
    validates :schedule_id
  end

  def save
    item = Item.create(name: name, detail: detail, price: price, images: images, category_id: category_id, status_id: status_id, fee_id: fee_id, prefecture_id: prefecture_id, schedule_id: schedule_id)
    brand = Brand.create(brand_name: brand_name)

    ItemBrandRelation.create(item_id: item.id, brand_id: brand.id)
  end

end
