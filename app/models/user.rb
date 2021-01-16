class User < ActiveRecord::Base
    has_many :meetings
    has_many :clients

    has_secure_password

    # validates_presence_of :email
    validates :email, presence: true, uniqueness: true
    # validates_uniqueness_of :email
    # validates :username, :password, presence: true 
end
