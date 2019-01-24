class LoginController < AppController

  # INDEX
  get "/" do
    erb :"login/index.html"
  end


  # CREATE
  post "/" do
    email = params[:email].downcase
    password = params[:password]

    if (Login.password_match? email, password) == true
      session[:logged_in] = true
      redirect "/users"
    else
      @correct_login = false
      erb :"login/index.html"
    end

  end

end
