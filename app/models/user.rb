class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image
  
  
# follow機能の実装：フォローしているuserの中間テーブルをacteive~、フォローされている方をpassive~とする
  #followする側のユーザー視点
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  #followする側のユーザー視点
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

# userがfollow済かどうか確認するメソッド
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  # フォロー先のuserのフォローされているユーザー（passive）の中に
  # 自分がいるかどうかを確認する
end
