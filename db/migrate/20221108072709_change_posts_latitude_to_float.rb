class ChangePostsLatitudeToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :latitude, :float
  end
end
