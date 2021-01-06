require './config/environment'
# require('dotenv').config() # this breaks it. why?

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use UsersController
use ClientsController
use MeetingsController
use SessionsController

run ApplicationController
