class RemoveLineNameFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :start_line_name, :string
  end
end
