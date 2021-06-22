# テーブル設計

## users テーブル

| Column             | Type   | Option      |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| family_name        | string | null: false |
| first_name_kana    | string | null: false |
| family_name_kana   | string | null: false |
| birthday           | string | null: false |

### Association

- has_many :items

## items テーブル

| Column             | Type       | Option                          |
| ------------------ | ---------- | ------------------------------- |
| name               | string     | null: false                     |
| price              | string     | null: false                     |
| detail             | text       |                                 |
| category           | string     | null: false                     |
| status             | string     | null: false                     |
| delivery_charge    | string     | null: false                     |
| shipment_source    | string     | null: false                     |
| shipping_date      | string     | null: false                     |
| user               | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_one :shipping_address

## shipping_address テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| number             | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| item               | references | null: false, foreign_key: true |

### Association 

- belongs_to :shipping_address