class Picture < ApplicationRecord
  belongs_to :post_image
  attachment :image
end
