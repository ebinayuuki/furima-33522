class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :status, :shipping_cost_burden, :prefecture, :shipping_day

  has_one_attached :image

  #商品出品アクティブハッシュのバリデーション
  with_options presence: true, numericality: { other_than: 0 } do
    validates :category_id, :status_id, :shipping_cost_burden_id, :prefecture_id, :shipping_day_id
  end

  #商品出品入力フィールドのバリデーション
  with_options presence: true do
    validates :name, length: { maximum: 40 }  
    validates :info, length: { maximum: 1000}
    validates :price, inclusion: { in: 300..9999999 }, format: { with: /\A[0-9]+\z/}
    validates :image
  end





end
