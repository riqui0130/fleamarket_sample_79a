class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days

  validates :images, presence: true
  validates :name, length: { maximum: 40 }, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :deliverycost_id, presence: true
  validates :delivery_days_id, presence: true
  validates :prefecture_id, presence: true
  validates :price, numericality: { only_integer: true,greater_than: 299, less_than: 9999999 }

  has_many :images, dependent: :destroy
  belongs_to :category
  belongs_to :seller, class_name: "User", optional: true,foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", optional: true,foreign_key: "buyer_id"
  belongs_to :auction, class_name: "User", optional: true,foreign_key: "auction_id"
end
