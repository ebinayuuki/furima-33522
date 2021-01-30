class CreateShippingAdds < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_adds do |t|
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :municipality, null: false
      t.string :house_number, null: false
      t.string :building
      t.string :phone, null: false
      t.references :purchase_record, null: false, foreign_key: true
      t.timestamps
    end
  end
end