require './config/environment'
require('dotenv').config()

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use EventsController
use UsersController
use ClientsController

run ApplicationController