class AddEndStationToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :end_station, :integer
  end
end
