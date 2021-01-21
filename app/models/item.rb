class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belong_to :category
  # , :status, :shipping_cost_burden, :prefecture, :shipping_day

  has_one_attached :image

  with_options presence: true, numericality: { other_than: 1 } do
    validates :category_id
    # validates :status_id
    # validates :shipping_cost_burden_id
    # validates :prefecture_id
    # validates :shipping_day_id

  end



end
