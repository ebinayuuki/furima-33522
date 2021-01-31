class RecordAdd
  include ActiveModel::Model
  attr_accessor :user, :item, :postal_code, :prefecture_id, :municipality, :house_number, :building, :phone, :purchase_record, :token


  with_options presence: true do
  validates :user, :item, :prefecture_id, :municipality, :house_number, :token
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :phone, format: { with: /\A\d{10}$|^\d{11}\z/}
end

def save
  
  purchase_record = PurchaseRecord.create(user_id: user, item_id: item)
  
  ShippingAdd.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, building: building, phone: phone, purchase_record_id: purchase_record.id)

end
end
