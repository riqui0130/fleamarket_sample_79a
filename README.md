# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# FLEAMARKET DB設計
## users テーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|family_name|string|null: false|
|family_name_kana|string|null: false, add_index: true|
|first_name|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
### Association
- has_many: creditcards
- has_many: favorites
- has_many: destinations
- has_many: products

## creditcards テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|name|string|null: false|
|card_number|integer|null: false|
|expiration_month|integer|null: false|
|expiration_year|integer|null: false|
|card_brand|integer|null: false|
|security_code|integer|null: false|
### Association
- belongs_to: users

## destinations テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|family_name|string|null: false|
|first_name|string|null: false|
|post_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|town|string|null: false|
|block|string|
|phone_number|integer|
### Association
- belongs_to: users

## products テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|product_name|string|null: false|
|description|text|null: false|
|product_status|text|null: false|
|shipping_fee|string|null: false|
|ship_from|string|null: false|
|lead_time|string|null: false|
|price|integer|null: false|
### Association
- has_many: favorites
- has_many: brands, through: products_brands 
- has_many: categories, through: products_categories 
- has_many: pictures
- belongs_to: users

## categories テーブル
|Column|Type|Options|
|------|----|-------|
|category|string|null: false|
### Association
- has_many: products, through: products_categories

## products_categories テーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :products
- belongs_to :categories

## brands テーブル
|Column|Type|Options|
|------|----|-------|
|brand|string|null: false|
### Association
- has_many: products, through: products_brands

## products_brands テーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|
### Association
- belongs_to: products
- belongs_to: brands

## pictures テーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|picture_url|string|null: false|
### Association
- belongs_to: products

## favorites テーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to: products
- belongs_to: users
