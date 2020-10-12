class Item < ApplicationRecord
  # extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :pref
  belongs_to_active_hash :deliverycost
  belongs_to_active_hash :delivery_days

  validate :images_presence
  validates :name, :text, :category_id, :condition_id, :deliverycost_id, :pref_id, :delivery_days_id,:user_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  has_many_attached :images
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :category

  #imageのバリデーション
  def images_presence
    if images.attached?
      # inputに保持されているimagesがあるかを確認
      if images.length > 10
        errors.add(:image, '10枚まで投稿できます')
      end
    else
      errors.add(:image, '画像がありません')
    end
  end
end
