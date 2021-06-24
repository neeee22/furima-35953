require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it'メールアドレスは、＠を含む必要があること' do
      @user.email = "google.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、６文字以上での入力が必須であること' do
      @user.password = Faker::Internet.password(min_length: 1,max_length: 5)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'パスワードは、数字だけでは登録できない' do
      @user.password = Faker::Number.number
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end
    it 'パスワードは、英字だけでは登録できない' do
      @user.password = Faker::Lorem.word
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end
    it 'パスワードとパスワード(確認)は、値の一致が必須であること' do
      @user.password_confirmation = Faker::Internet.password(min_length: 6) 
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
    end
    it 'お名前(全角)は、全角(漢字・ひらがな・カタカナ)での入力が必須であること' do
    end
    it 'お名前(全角)は、全角(カタカナ)での入力が必須であること' do
    end
    it '生年月日が必須であること' do
    end
  end

  describe 'トップページ' do
    it 'ログアウト状態の場合には、トップページ(商品一覧ページ)のヘッダーに、「新規登録」「ログイン」ボタンが表示されること' do
    end
    it 'ログイン状態の場合には、トップページ(商品一覧ページ)のヘッダーに、「ユーザーのニックネーム」と「ログアウト」ボタンが表示されること' do
    end
    it 'トップページ(商品一覧ページ)ヘッダーの、「新規登録」「ログイン」ボタンをクリックすると、各ページに遷移できること' do
    end
    it 'トップページ(商品一覧ページヘッダーの、「ログアウト」ボタンをクリックすると、ログアウトできること' do
    end
  end
end
