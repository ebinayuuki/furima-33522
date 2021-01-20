require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば登録可' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailに一意性がないと登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれないと登録できない' do
        @user.email = "@"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordが6文字以上でないと登録できない' do
        @user.password = "111aa"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'passwordは半角英数混合ではないと登録できない' do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password","Password is invalid"       
      end
      it 'passwordは確認用含めて２回入力しないと登録できない' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        @user.password = "121212"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "名字が空だと登録できない" do
        @user.last_name = ""
        @user.first_name = "太郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end
      it "名前が空だと登録できない" do
        @user.last_name = "高田"
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end
      it "名字が全角でないと登録できない" do
        @user.last_name = "1a"
        @user.first_name = "太郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it "名前が全角でないと登録できない" do
        @user.last_name = "高田"
        @user.first_name = "1a"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "名字のフリガナがないと登録できない" do
        @user.last_name_katakana = ""
        @user.first_name_katakana = "タロウ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana can't be blank", "Last name katakana is invalid")
      end
      it "名前のフリガナがないと登録できない" do
        @user.last_name_katakana = "タカダ"
        @user.first_name_katakana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana can't be blank", "First name katakana is invalid")
      end
      it "名字のフリガナは全角カタカナでないと登録できない" do
        @user.last_name_katakana = "高田"
        @user.first_name_katakana = "タロウ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana is invalid")
      end
      it "名前のフリガナは全角カタカナでないと登録できない" do
        @user.last_name_katakana = "タカダ"
        @user.first_name_katakana = "太郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana is invalid")
      end
      it "生年月日が空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

    end
  end
end
