class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  attachment :image
  accepts_attachments_for :pictures, attachment: :image

  validates :user_name, length: {minimum: 2, maximum: 8}, presence: true
  validates :gender, presence: true
  validates :birth_year, presence: true
  validates :introduction, length: { maximum: 200}
  
  # passwordとaccount_nameについては半角英数のみ対応
  VALID_ACCOUNT_NAME = /\A[a-z0-9]+\z/i
  validates :account_name, format: { with: VALID_ACCOUNT_NAME }, length: {minimum: 2, maximum: 8}, presence: true
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }

# follow機能の実装：フォローしているuserの中間テーブルをacteive~、フォローされている方をpassive~とする
  #followする側のユーザー視点
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower, dependent: :destroy
  #followする側のユーザー視点
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following, dependent: :destroy

# userがfollow済かどうか確認するメソッド
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  # フォロー先のuserのフォローされているユーザー（passive）の中に
  # 自分がいるかどうかを確認する
end
