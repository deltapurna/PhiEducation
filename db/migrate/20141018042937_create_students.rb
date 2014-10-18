class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :room_id

      t.timestamps
    end
  end
end
