class UsersController < AppController

  # INDEX
  get "/" do
    if session[:logged_in] == true
      @users = User.all
      erb :"users/index.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # NEW
  get "/new" do
    if session[:logged_in] == true
      @user = User.new
      erb :"users/new.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # SHOW
  get "/:id" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @user = User.find id
      erb :"users/show.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # EDIT
  get "/:id/edit" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @user = User.find id
      erb :"users/edit.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # CREATE
  post "/" do
    if session[:logged_in] == true
      one = params[:email]
      two = one.strip
      three = two.end_with?("@spartaglobal.com")

      if App.correct_form_entry?(params[:first_name], params[:last_name]) == true && params[:email].strip.downcase.end_with?("@spartaglobal.com") && App.correct_password?(params[:password]) == true
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

    else
      @not_logged_in = true
      erb :"login/index.html"
    end

  end

  # UPDATE
  put "/:id" do
    if session[:logged_in] == true
      id = params[:id].to_i

      if App.correct_form_entry?(params[:first_name], params[:last_name]) == true && params[:email].strip.downcase.end_with?("@spartaglobal.com") && App.correct_password?(params[:password]) == true
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

    else
      @not_logged_in = true
      erb :"login/index.html"
    end

  end

  # DESTROY
  delete "/:id" do
    if session[:logged_in] == true
      id = params[:id].to_i
      User.destroy id
      redirect "/users"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

end
