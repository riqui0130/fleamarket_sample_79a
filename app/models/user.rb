class User < ApplicationRecord
  has_many :saling_items, -> { where("seller_id is not NULL && buyer_id is NULL") }, class_name: "Item"
  has_many :sold_items, -> { where("seller_id is not NULL && buyer_id is not NULL && auction_id is NULL") }, class_name: "Item"
  has_many :auction_items, -> { where("seller_id is not NULL && auction_id is not NULL && buyer_id is NULL") }, class_name: "Item"
end
