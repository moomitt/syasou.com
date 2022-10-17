class AddEndStationPrefectureToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :end_station_prefecture, :integer
  end
end
