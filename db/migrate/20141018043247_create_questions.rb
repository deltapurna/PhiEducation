class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.string :type
      t.integer :room_id

      t.timestamps
    end
  end
end
