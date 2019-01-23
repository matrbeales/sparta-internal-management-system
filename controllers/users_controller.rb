class UsersController < AppController

  # INDEX
  get "/" do
    @users = User.all
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
    id = params[:id].to_i
    @user = User.find id
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
    redirect "/users"
  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i
    user = User.find id

    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password = params[:password]
    user.cohort_id = params[:cohort_id]
    user.role_id = params[:role_id]


    user.save
    redirect "/users/#{id}"
  end

  # DESTROY
  delete "/:id" do
    id = params[:id].to_i
    User.destroy id
    redirect "/users"
  end
end
