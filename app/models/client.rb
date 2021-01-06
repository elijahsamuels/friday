class Client < ActiveRecord::Base
    belongs_to :user

    has_secure_password

    # validates_presence_of :email, :password

end
