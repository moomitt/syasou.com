class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_one_attached :user_image

  has_many :follows
  has_many :followings, through: :follows, source: :follow
  has_many :reverse_of_follows, class_name: 'Follow', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_follows, source: :user

  validates :name, presence: true, length: { minimum: 2, maximum: 10 }

  def follow(other_user)
    follows.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    follow = follows.find_by(follow_id: other_user.id)
    follow.destroy if follow
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
