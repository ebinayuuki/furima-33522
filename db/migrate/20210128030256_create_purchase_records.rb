class CreatePurchaseRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_records do |t|
      t.references :user, foreign_key: true, null: false 
      t.references :item, foreign_key: true, null: false 
      t.timestamps
    end
  end
end
