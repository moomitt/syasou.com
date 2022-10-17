class AddStartStationPrefectureToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :start_station_prefecture, :integer
  end
end
