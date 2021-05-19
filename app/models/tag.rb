class Tag < ApplicationRecord

  belongs_to :genre

  has_many :post_tags, dependent: :destroy
  has_many :post_images, through: :post_tags
end
