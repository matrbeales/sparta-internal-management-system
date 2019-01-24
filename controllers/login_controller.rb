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
      @correct_password = true
      erb :"login/index.html"
    else
      @correct_password = false
      erb :"login/index.html"
    end

  end

end
