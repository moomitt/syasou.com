class AddEndStaionNameToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :end_station_name, :string
  end
end
