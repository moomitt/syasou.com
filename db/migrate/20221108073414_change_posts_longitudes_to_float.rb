class ChangePostsLongitudesToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :longitude, :float
  end
end
