class Genre < ApplicationRecord

has_many :tags, dependent: :destroy

end
