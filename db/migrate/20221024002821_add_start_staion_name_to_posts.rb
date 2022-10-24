class AddStartStaionNameToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :start_station_name, :string
  end
end
