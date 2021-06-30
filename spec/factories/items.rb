FactoryBot.define do
  factory :item do
    association :user
    name { Faker::String.random }
    detail { Faker::String.random }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id { Faker::Number.between(from: 2, to: 11) }
    status_id { Faker::Number.between(from: 2, to: 7) }
    fee_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    schedule_id { Faker::Number.between(from: 2, to: 4) }
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end
