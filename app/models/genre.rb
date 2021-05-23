class Genre < ApplicationRecord

has_many :tags, dependent: :destroy

validates :name, presence: true
validates :name, length: {minimum: 2, maximum: 10}

end
