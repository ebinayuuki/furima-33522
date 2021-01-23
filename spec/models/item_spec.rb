require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品が成功する場合' do
      it '全項目が正しく入力されてれば投稿できる' do
        expect(@item).to be_valid
      end
    end
  end

  context '出品ができない場合' do
    it '商品画像を1枚つけることが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が必須であること' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it '商品の説明が必須であること' do
      @item.info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Info can't be blank")
    end
    it 'カテゴリーの情報が必須であること' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 0')
    end
    it '商品の状態についての情報が必須であること' do
      @item.status_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Status must be other than 0')
    end
    it '配送料の負担についての情報が必須であること' do
      @item.shipping_cost_burden_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping cost burden must be other than 0')
    end
    it '発送元の地域についての情報が必須であること' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 0')
    end
    it '発送までの日数についての情報が必須であること' do
      @item.shipping_day_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping day must be other than 0')
    end
    it '価格についての情報が必須であること' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが300~9999999円の範囲であること(下限)' do
      @item.price = '299'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
    it 'priceが300~9999999円の範囲であること(上限)' do
      @item.price = '10000000'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
    it 'priceが半角英数字であること(ひらがな)' do
      @item.price = 'あああ'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
    it 'priceが半角英数字であること(半角英数)' do
      @item.price = 'aaa'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
  end
end
