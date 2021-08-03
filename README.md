# テーブル設計

## users テーブル

| Column             | Type   | Option                    |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders
- has_one :cards

## items テーブル

| Column             | Type       | Option                          |
| ------------------ | ---------- | ------------------------------- |
| name               | string     | null: false                     |
| price              | integer    | null: false                     |
| detail             | text       | null: false                     |
| category_id        | integer    | null: false                     |
| status_id          | integer    | null: false                     |
| fee_id             | integer    | null: false                     |
| prefecture_id      | integer    | null: false                     |
| schedule_id        | integer    | null: false                     |
| user               | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_one :order
- has_many :brands

### orders テーブル

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| house_number       | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

### Association 

- belongs_to :order

## cards テーブル

| Column         | Type       | Option                         |
| -------------- | ---------- | ------------------------------ |
| customer_token | string     | null: false                    |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## brands テーブル

| Column | Type       | Option           |
| -------| ---------- | -----------------|
| name   | string     | uniqueness: true |

### Association

- has_many :items

## item_brand_relations テーブル

| Column | Type       | Option            |
| -------| ---------- | ----------------- |
| item   | references | foreign_key: true |
| brand  | references | foreign_key: true |

### Association

- belongs_to :item
- belongs_to :brand