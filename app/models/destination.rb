class Destination < ApplicationRecord
  belongs_to :user, optional: true
  validates :family_name, :first_name, :post_code, :prefecture_id, :city, :town, presence: true
  validates :family_name,
    format: {with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
  validates :first_name,
    format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
  validates :post_code,
    format: { with: /\A\d{7}\z/, message: "をハイフン(-)無しで７桁の半角数字で入力してください" }
end