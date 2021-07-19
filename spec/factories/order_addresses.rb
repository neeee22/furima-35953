FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '000-0000' }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { '新宿区' }
    house_number { '新宿1-1-1' }
    building_name { '新宿ビル' }
    phone_number { '00000000000' }
  end
end
