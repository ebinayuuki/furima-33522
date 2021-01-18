# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| nickname            | string | null: false               |
| first_name          | string | null: false               |
| last_name           | string | null: false               |
| first_name_katakana | string | null: false               |
| last_name_katakana  | string | null: false               |
| birthday            | date   | null: false               |

### Association

- has_many :items
- has_many :purchase_records 


## items テーブル

| Column                  | Type         | Options                        |
| ------------------------| ------------ | ------------------------------ |
| name                    | string       | null: false                    |
| info                    | text         | null: false                    |
| category_id             | integer      | null: false                    |
| status_id               | integer      | null: false                    |
| shipping_cost_burden_id | integer      | null: false                    |
| shipping_prefecture_id  | integer      | null: false                    |
| shipping_day_id         | integer      | null: false                    |
| price                   | integer      | null: false                    |
| user                    | reference    | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record


## purchase_records テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_add


## shipping_adds テーブル


| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture         | integer    | null: false                    |
| municipality       | string     | null: false                    |
| house_number       | string     | null: false                    |
| building           | string     |                                |
| phone              | string     | null: false                    |
| purchase_record    | references | null: false, foreign_key: true |

### Association

- belongs_to : purchase_record
