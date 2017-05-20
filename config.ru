require "./config/environment"

if ActiveRecord::Migrator.needs_migration?
  raise "Migrations are pending. Run 'rake db:migrate' to resolve the issue."
end

use Rack::MethodOverride
use CategoriesController
use ExpensesController
use RegistrationController
use SessionController
use UserController
run ApplicationController
