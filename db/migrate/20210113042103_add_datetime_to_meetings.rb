class AddDatetimeToMeetings < ActiveRecord::Migration
  def change
    change_table :meetings do |t|
      t.datetime :meeting_datetime
      t.date :meeting_date
      t.time :meeting_time
    end
  end
end
