class Post < ApplicationRecord
  belongs_to :user
  has_many post_tags, dependent: :destroy
  has_many bookmarks, dependent: :destroy
  has_many comments, dependent: :destroy
  has_one_attached :post_image
end
