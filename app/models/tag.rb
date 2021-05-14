class Tag < ApplicationRecord
  
  belongs_to :genre
  
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :post_images, through: :tag_maps
  
end
