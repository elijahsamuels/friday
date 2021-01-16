class AddTestDataForMeetings < ActiveRecord::Migration
  def change
      change_table :meetings do |t|
        t.string :client_name
        t.string :user_name
    end
  end
end