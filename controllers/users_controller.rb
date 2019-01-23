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
    one = params[:email]
    two = one.strip
    three = two.end_with?("@spartaglobal.com")

    if App.correct_form_entry?(params[:first_name], params[:last_name]) == true && params[:email].strip.downcase.end_with?("@spartaglobal.com")
      user = User.new
      user.first_name = params[:first_name].strip
      user.last_name = params[:last_name].strip
      user.email = params[:email].strip.downcase
      user.password = params[:password].strip
      user.cohort_id = params[:cohort_id]
      user.role_id = params[:role_id]

      user.save
      redirect "/users"
    else
      @redirect = true
      @user = User.new
      erb :"users/new.html"
    end

  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i

    if App.correct_form_entry?(params[:first_name], params[:last_name]) == true && params[:email].strip.downcase.end_with?("@spartaglobal.com")
      user = User.find id

      user.first_name = params[:first_name].strip
      user.last_name = params[:last_name].strip
      user.email = params[:email].strip.downcase
      user.password = params[:password].strip
      user.cohort_id = params[:cohort_id]
      user.role_id = params[:role_id]


      user.save
      redirect "/users/#{id}"
    else
      @redirect = true
      @user = User.find id
      erb :"users/edit.html"
    end

  end

  # DESTROY
  delete "/:id" do
    id = params[:id].to_i
    User.destroy id
    redirect "/users"
  end
end
