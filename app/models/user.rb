class User < ActiveRecord::Base
    has_many :meetings
    has_many :clients

    has_secure_password

    validates_presence_of :email, :password

end
