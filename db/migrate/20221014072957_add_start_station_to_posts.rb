class AddStartStationToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :start_station, :integer
  end
end
