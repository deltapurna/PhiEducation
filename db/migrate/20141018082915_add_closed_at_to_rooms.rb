class AddClosedAtToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :closed_at, :datetime
  end
end
