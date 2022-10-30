class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :post_images
  accepts_nested_attributes_for :post_images_attachments, allow_destroy: true

  validates :body,                     presence: true, length: { maximum: 200 }
  validates :time_zone,                                length: { maximum: 200 }
  validates :spot,                                     length: { maximum: 200 }
  validates :start_station,            presence: true
  validates :end_station,              presence: true
  validates :line,                     presence: true
  validates :start_station_prefecture, presence: true
  validates :end_station_prefecture,   presence: true
  validates :latitude,                 presence: true
  validates :longitude,                presence: true
  validates :start_station_name,       presence: true
  validates :end_station_name,         presence: true
  validates :line_name,                presence: true

  def bookmarked_by?(user)                    #すでにブックマークされているか判定するメソッド
    bookmarks.exists?(user_id: user.id)
  end
end
