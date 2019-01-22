class UsersController < Sinatra::Base

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
    @users = User.all
    puts @users
    erb :"users/index.html"
  end

  # NEW
  get "/new" do
    # @user
    @user = User.new
    erb :"users/new.html"
  end

  # SHOW
  get "/:id" do
    id = params[:id].to_i
    @user = User.find id

    erb :"users/show.html"
  end

  # EDIT
  get "/:id/edit" do
    # @user


    erb :"users/edit.html"
  end

  # CREATE
  post "/" do
    user = User.new
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password = params[:password]
    user.cohort_id = params[:cohort_id]
    user.role_id = params[:role_id]

    user.save
    redirect "/"
  end

  # UPDATE
  put "/:id" do


    redirect "/#{id}"
  end

  # DESTROY
  delete "/:id" do


    redirect "/"
  end


end
