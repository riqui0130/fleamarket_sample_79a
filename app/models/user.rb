class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, uniqueness: true
  validates :family_name, 
    format: {with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
  validates :first_name,
    format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
  validates :family_name_kana,
    format: { with: /\A([ァ-ン]|ー)+\z/, message: 'を全角カタカナで入力してください' }
  validates :first_name_kana,
    format: { with: /\A([ァ-ン]|ー)+\z/, message: 'を全角カタカナで入力してください' }
  validates :password, length: { minimum:7, message: "は7文字以上で入力してください"}
  validates :email, 
    format: {with: /\A[\w._@-]*[@][\w._@-]*\z/, message: "は半角英数で入力してください"}
  validates :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :email, :birth_day, :password, presence: true


  has_many :creditcards
  has_many :favorites
  has_one :destination
  has_many :items, through: :favorites
  has_many :comments
end
