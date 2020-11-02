class Image < ApplicationRecord
  mount_uploader :images, ImageUploader
  belongs_to :item,optional: true
end
