class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :postage
  belongs_to_active_hash :days

  enum status:         ["新品、未使用","未使用に近い","目立った傷や汚れなし","やや傷や汚れあり","傷や汚れあり","全体的に状態が悪い"]
  enum postage:  ["送料込み(出品者負担)","着払い(購入者負担)"]
  enum days:     ["1~2日で発送","2~3日で発送","4~7日で発送"]

  validates :images, presence: true
  validates :name, length: { maximum: 40 }, presence: true
  validates :text, presence: true
  validates :price, presence: true
  validates :status_id, presence: true
  validates :postage_id, presence: true
  validates :days_id, presence: true
  validates :prefecture_id, presence: true
  validates :price, numericality: { only_integer: true,greater_than: 299, less_than: 9999999 }

  has_many :images, dependent: :destroy
  belongs_to :category
  has_many :pictures
  belongs_to :seller, class_name: "User", optional: true,foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", optional: true,foreign_key: "buyer_id"
  belongs_to :auction, class_name: "User", optional: true,foreign_key: "auction_id"
end
