require "pg"
require "jwt"
require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?

require_relative "controllers/app_controller.rb"
require_relative "controllers/cohorts_controller.rb"
require_relative "controllers/roles_controller.rb"
require_relative "controllers/specialisations_controller.rb"
require_relative "controllers/users_controller.rb"
require_relative "controllers/login_controller.rb"
require_relative "controllers/api_controller.rb"

require_relative "models/app.rb"
require_relative "models/cohort.rb"
require_relative "models/role.rb"
require_relative "models/specialisation.rb"
require_relative "models/user.rb"
require_relative "models/login.rb"

use Rack::MethodOverride
map('/') {run LoginController}
map('/users') {run UsersController}
map('/cohorts') {run CohortsController}
map('/roles') {run RolesController}
map('/specialisations') {run SpecialisationsController}
map('/api') {run ApiController}
