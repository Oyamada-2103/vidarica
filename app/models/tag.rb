class Tag < ApplicationRecord

  belongs_to :genre

  has_many :post_tags, foreign_key: :tag_id, dependent: :destroy
  has_many :posts, through: :post_tags, foreign_key: :tag_id, dependent: :destroy
end
