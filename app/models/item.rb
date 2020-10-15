class Item < ApplicationRecord
  belongs_to :category
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :postage
  belongs_to_active_hash :shippingday

  validate :images_presence
  validates :name, length: { maximum: 40 }, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :status_id, presence: true
  validates :postage_id, presence: true
  validates :shippingday_id, presence: true
  validates :prefecture_id, presence: true
  validates :category_id, presence: true
  validates :price,numericality: { only_integer: true,greater_than: 300, less_than: 9999999 }

end
