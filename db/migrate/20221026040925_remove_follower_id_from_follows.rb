class RemoveFollowerIdFromFollows < ActiveRecord::Migration[6.1]
  def change
    remove_column :follows, :follower_id, :integer
  end
end
