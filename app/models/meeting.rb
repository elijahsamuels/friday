class Meeting < ActiveRecord::Base
    belongs_to :client # client is the event is the client etc...
    belongs_to :user
end
