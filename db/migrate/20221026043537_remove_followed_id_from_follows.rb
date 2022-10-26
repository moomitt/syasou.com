class RemoveFollowedIdFromFollows < ActiveRecord::Migration[6.1]
  def change
    remove_column :follows, :followed_id, :integer
  end
end
