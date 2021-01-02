class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :event_date
      t.string :event_link
      t.integer :client_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
