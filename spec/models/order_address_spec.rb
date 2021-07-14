require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    item = FactoryBot.build(:item)
    @order_address = FactoryBot.build(:order_address,item_id: item.id, user_id: item.user_id)
  end

  context '内容に問題ない場合' do
    it "住所とカード情報があれば保存ができること" do
      expect(@order_address).to be_valid
    end
    it "建物名は空でも登録できること" do
      @order_address.building_name = ""
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "tokenが空では登録できないこと" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it "郵便番号が空では登録できないこと" do
      @order_address.postal_code = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it "郵便番号はハイフンが必要" do
      @order_address.postal_code = "0000000"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it "市町村区が空では登録できないこと" do
      @order_address.city = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it "番地が空では登録できないこと" do
      @order_address.house_number = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("House number can't be blank")
    end
    it "電話番号が空では登録できないこと" do
      @order_address.phone_number = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it "電話番号は半角数字のみ登録できること" do
      @order_address.phone_number = "090-0909-0909"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number は、半角数字で入力してください")
    end
    it "電話番号は12桁以上では購入できないこと" do
      @order_address.phone_number = "009009090909"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number は、半角数字で入力してください")
    end
    it "都道府県を選択しなければ登録できないこと" do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture must be other than 0")
    end
    it "user_idが空では購入できないこと" do
      @order_address.user_id = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end
    it "item_idが空では購入できないこと" do
      @order_address.item_id = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
  end
end