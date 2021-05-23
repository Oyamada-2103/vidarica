class Tag < ApplicationRecord

  belongs_to :genre

  has_many :post_tags, dependent: :destroy
  has_many :post_images, through: :post_tags

  validates :tag_name, length: {minimum: 1, maximum: 10}, presence: true
  validates :genre_id, presence: true

end
