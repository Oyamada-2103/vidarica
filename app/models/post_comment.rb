class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :post_image


validates :name, length: {minimum: 1, maximum: 200}, presence: true

end
