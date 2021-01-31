FactoryBot.define do
  factory :user do
    id                    {1}
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '000aaa' }
    password_confirmation { password }
    first_name            { 'タロウ' }
    last_name             { '山田' }
    first_name_katakana   { 'タロウ' }
    last_name_katakana    { 'ヤマダ' }
    birthday              { '2000-02-02' }
  end
end
