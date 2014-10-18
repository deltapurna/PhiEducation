class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :code
      t.integer :teacher_id

      t.timestamps
    end
  end
end
