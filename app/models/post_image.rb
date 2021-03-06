class PostImage < ApplicationRecord

  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 複数枚画像投稿
  has_many :pictures, dependent: :destroy
  accepts_attachments_for :pictures, attachment: :image

  # tag機能の実装
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags


  validates :caption, length: { maximum: 500}, presence: true
  

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_image_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_image_tag
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end