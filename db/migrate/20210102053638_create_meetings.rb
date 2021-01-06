class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.integer :event_date_id
      t.integer :event_link_id
      t.integer :client_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
