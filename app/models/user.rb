class User < ActiveRecord::Base
    has_many :meetings
    has_many :clients

    has_secure_password

    validates_presence_of :email#, :password
    validates_uniqueness_of :username

    # validates :username, :password, presence: true 
end
