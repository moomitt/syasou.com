class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :goods, dependent: :destroy

  validates :text, presence: true, length: { maximum: 150 }

  def gooded_by?(user)                    # すでにいいねされているか判定するメソッド
    goods.exists?(user_id: user.id)
  end
end
