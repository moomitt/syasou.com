class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :post_image do |attachable|
    attachable.variant :thumb, resize_to_fill: [150, 100]
  end

  def bookmarked_by?(user)                    #すでにブックマークされているか判定するメソッド
    bookmarks.exists?(user_id: user.id)
  end
end
