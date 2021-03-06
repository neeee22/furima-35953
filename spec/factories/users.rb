FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    id { Faker::Number.between(from: 1, to: 9_999_999) }
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_kana        { person.last.katakana }
    first_name_kana       { person.first.katakana }
    birthday              { Faker::Date.birthday(min_age: 5, max_age: 100) }
  end
end
