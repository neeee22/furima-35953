require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '出品する' do
    context '出品できる場合' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できない場合' do
      it '商品名が入力されていない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が入力されていない' do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end
      it '画像が添付されていない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '価格が入力されていない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が数字で入力されていない' do
        @item.price = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格が300円以上でない' do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '価格が9999999円以下でない' do
        @item.price = '1000000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'カテゴリーが選択されていない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it '商品の状態が選択されていない' do
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end
      it '配送料の負担が選択されていない' do
        @item.fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Fee must be other than 1")
      end
      it '発送元の地域が選択されていない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '発送までの日数が選択されていない' do
        @item.schedule_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Schedule must be other than 1")
      end
    end
  end
end
