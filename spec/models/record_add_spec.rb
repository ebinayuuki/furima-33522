require 'rails_helper'

RSpec.describe RecordAdd, type: :model do
  before do
     sleep(0.1)
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @record_add = FactoryBot.build(:record_add, user: @user[:id], item: @item[:id])
  end

  describe '商品購入機能' do
    context '購入が成功する場合' do
      it '全項目が正しく入力されてれば購入できる' do
        expect(@record_add).to be_valid
      end
      it 'buildingが空でも購入できる' do
        @record_add.building = ''
        expect(@record_add).to be_valid
      end
    end
  end

  context '購入が失敗する場合' do
    it 'postal_codeが空' do
      @record_add.postal_code = ''
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeにハイフン無し' do
      @record_add.postal_code = '1110000'
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include('Postal code is invalid')
    end
    it 'prefecture_idが空' do
      @record_add.prefecture_id = 0
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include('Prefecture must be other than 0')
    end
    it 'municipalityが空' do
      @record_add.municipality = ''
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Municipality can't be blank")
    end
    it 'house_numberが空' do
      @record_add.house_number = ''
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("House number can't be blank")
    end
    it 'phoneが空' do
      @record_add.phone = ''
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Phone can't be blank")
    end
    it 'phoneが12桁以上' do
      @record_add.phone = '123456789012'
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include('Phone is invalid')
    end
    it 'userが空' do
      @record_add.user = ''
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("User can't be blank")
    end
    it 'itemが空' do
      @record_add.item = ''
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Item can't be blank")
    end
    it 'tokenが空' do
      @record_add.token = ''
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Token can't be blank")
    end
    it 'phoneが数字のみ以外' do
      @record_add.phone = '000aaaabbbb'
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Phone is invalid")
    end
    it 'phoneが全角数字' do
      @record_add.phone = '０９０１１１１２２２２'
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Phone is invalid")
    end
    it 'phoneが9桁以下' do
      @record_add.phone = '090111222'
      @record_add.valid?
      expect(@record_add.errors.full_messages).to include("Phone is invalid")
    end
  end
end
