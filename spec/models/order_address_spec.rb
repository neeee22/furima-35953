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
      expect(@order_address.errors.full_messages).to include("カード情報を入力してください")
    end
    it "郵便番号が空では登録できないこと" do
      @order_address.postal_code = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
    end
    it "郵便番号はハイフンが必要" do
      @order_address.postal_code = "0000000"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("郵便番号は、ハイフン(-)を含めて入力してください")
    end
    it "市町村区が空では登録できないこと" do
      @order_address.city = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("市町村区を入力してください")
    end
    it "番地が空では登録できないこと" do
      @order_address.house_number = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("番地を入力してください")
    end
    it "電話番号が空では登録できないこと" do
      @order_address.phone_number = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
    end
    it "電話番号は半角数字のみ登録できること" do
      @order_address.phone_number = "090-0909-0909"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は、半角数字で入力してください")
    end
    it "電話番号は12桁以上では購入できないこと" do
      @order_address.phone_number = "009009090909"
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("電話番号は、半角数字で入力してください")
    end
    it "都道府県を選択しなければ登録できないこと" do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("都道府県を選択してください")
    end
    it "user_idが空では購入できないこと" do
      @order_address.user_id = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Userを入力してください")
    end
    it "item_idが空では購入できないこと" do
      @order_address.item_id = ""
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Itemを入力してください")
    end
  end
end