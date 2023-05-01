class Category < ApplicationRecord
  validates :name, presence: true
  has_many :product, dependent: :restrict_with_exception
end
