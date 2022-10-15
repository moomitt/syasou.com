class AddSpotToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :spot, :string
  end
end
