class Product < ApplicationRecord
  ORDER_BY = {
    newest: "created_at DESC",
    expensives: "price DESC",
    cheapest: "price ASC"
  }
  has_one_attached :photo
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  belongs_to :category
  belongs_to :user, default: -> { Current.user }
end
