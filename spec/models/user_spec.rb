require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '保存できる場合' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@user).to be_valid
      end
      it 'パスワードは、6文字以上であれば登録できる' do
        @user.password = 'a11111'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end
    context '保存できない場合' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'メールアドレスは、＠を含む必要があること' do
        @user.email = 'google.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードは、5文字以下では登録できない' do
        @user.password = Faker::Internet.password(min_length: 1, max_length: 5)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードは、数字だけでは登録できない' do
        @user.password = Faker::Number.number
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは、英字だけでは登録できない' do
        @user.password = Faker::Lorem.word
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
      end
      it 'パスワードとパスワード(確認)は、値の一致が必須であること' do
        @user.password_confirmation = Faker::Internet.password(min_length: 6)
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'お名前(全角)は、名字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください")
      end
      it 'お名前(全角)は、名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください")
      end
      it 'お名前(全角)は、全角(漢字・ひらがな・カタカナ)での入力が必須であること(名字)' do
        @user.last_name = Faker::Name.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include('姓には全角文字を使用してください')
      end
      it 'お名前(全角)は、全角(漢字・ひらがな・カタカナ)での入力が必須であること(名前)' do
        @user.first_name = Faker::Name.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include('名には全角文字を使用してください')
      end
      it 'お名前カナ(全角)は、全角(カタカナ)での入力が必須であること(名字)' do
        @user.last_name_kana = @user.last_name
        @user.valid?
        expect(@user.errors.full_messages).to include('姓(カナ)には全角カナ文字を使用してください')
      end
      it 'お名前カナ(全角)は、全角(カタカナ)での入力が必須であること(名前)' do
        @user.first_name_kana = @user.first_name
        @user.valid?
        expect(@user.errors.full_messages).to include('名(カナ)には全角カナ文字を使用してください')
      end
      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
