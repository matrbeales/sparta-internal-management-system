class RolesController < Sinatra::Base

  # Fixes reloader
  configure :development do
    register Sinatra::Reloader
  end

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  # INDEX
  get "/" do
    @roles = Role.all
    erb :"roles/index.html"
  end

  # NEW
  get "/new" do
    # @role
    get "/new" do
      @role = Role.new
    erb :"roles/new.html"
  end

  # SHOW
  get "/:id" do
    # @role
    id = params[:id].to_i
    @role = Role.find id
    erb :"roles/show.html"
  end

  # EDIT
  get "/:id/edit" do
    # @role
    id = params[:id].to_i
    @role = Role.find id
    erb :"roles/edit.html"
  end

  # CREATE
  post "/" do
    post "/" do
      role = Role.new
      role.role_id = params[:role_id]
      role.role_name = params[:role_name]
      role.save
    redirect "/roles"
  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i
    role = Role.find id
    role.role_id = params[:role_id]
    role.role_name = params[:role_name]
    role.save
    redirect "/roles/#{id}"
  end

  # DESTROY
  delete "/:id" do
    id = params[:id].to_i
    Role.destroy id
    redirect "/roles"
  end


end
