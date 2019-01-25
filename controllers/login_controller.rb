class LoginController < AppController

  # INDEX
  get "/" do
    erb :"login/index.html"
  end

  # A post request is sent when the user tries to submit their email & password.
  # This checks those details, and applies a session if they match
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

  # delete request sent when the user tries to log out
  delete "/" do
    session[:logged_in] = false
    redirect "/"
  end

end
