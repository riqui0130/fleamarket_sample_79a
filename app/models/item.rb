class Item < ApplicationRecord
  has_many :pictures
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
end
