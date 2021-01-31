FactoryBot.define do
  factory :record_add do
    postal_code { '111-1111' }
    prefecture_id { 1 }
    municipality { '埼玉県' }
    house_number { '1-2-34' }
    building { 'メゾン' }
    phone { '09011110000' }
    user { 1 }
    item { 1 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
