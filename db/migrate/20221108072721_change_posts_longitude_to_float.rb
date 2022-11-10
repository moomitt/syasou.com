class ChangePostsLongitudeToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :longitude, :float
  end
end
