class AddTimeZoneToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :time_zone, :string
  end
end
