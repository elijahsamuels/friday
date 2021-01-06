class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :password_digest
      t.string :username
      t.string :email
      t.integer :phone
      t.string :first_name
      t.string :last_name
      t.date :event_date
      t.integer :event_link_id
      t.datetime :meeting_date

      t.timestamps null: false
    end
  end
end


#### NOTES FOR FUTURE USE ####
 
#   create_table :calendar_days, id: false do |t|
#     t.date :day, null: false
#     t.integer :year, null: false
#     t.integer :month, null: false
#     t.integer :day_of_month, null: false
#     t.integer :day_of_week, null: false
#     t.integer :quarter, null: false
#     t.boolean :business_day, null: false
#     t.boolean :week_day, null: false
#   end

#   execute "ALTER TABLE calendar_days ADD PRIMARY KEY (day)"

#   class CalendarDay < ActiveRecord::Base
#     self.primary_key = :day
#   end
#   Data:

#   # Non-exhaustive, needs to be customized for your needs.
#   def business_day?(d)
#     matches = ->(month, day) { [month, day] == [d.month, d.day] }
#     falls_on = ->(month, wday, r) {
#       [month, wday] == [d.month, d.wday] && r.cover?(d.day)
#     }

#     return false if [0,6].include?(d.wday) # Weekends
#     return false if matches[1, 1]   # New Years
#     return false if matches[7, 4]   # Independence Day
#     return false if matches[12, 25] # Christmas
#     return false if matches[11, 11] # Veterans Day
#     return false if falls_on[1,  1, 15..21] # MLK Day
#     return false if falls_on[5,  1, 25..31] # Memorial Day
#     return false if falls_on[9,  1, 1..7]   # Labor Day
#     return false if falls_on[11, 4, 22..28] # Thanksgiving
#     true
#   end

#   task populate_calendar_days: :environment do
#   (Date.new(2013,1,1)...Date.new(2014,1,1)).each do |d|
#     day = CalendarDay.new(
#       year:         d.year,
#       month:        d.month,
#       day_of_month: d.day,
#       day_of_week:  d.wday,
#       quarter:      (d.month / 4) + 1,
#       week_day:     ![0,6].include?(d.wday),
#       business_day: business_day?(d)
#     )
#     day.day = d
#     day.save!
#   end