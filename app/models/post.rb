class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :post_images
  accepts_nested_attributes_for :post_images_attachments, allow_destroy: true

  def bookmarked_by?(user)                    #すでにブックマークされているか判定するメソッド
    bookmarks.exists?(user_id: user.id)
  end
end
