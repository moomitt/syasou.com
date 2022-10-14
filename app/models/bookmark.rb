class Bookmark < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user_id, uniqueness: { scope: :post_id }  #ロード中の重複登録を防ぐ
end
