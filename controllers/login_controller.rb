class LoginController < AppController

  # INDEX
  get "/" do
    erb :"login/index.html"

  end

  # NEW
  get "/new" do
    erb :"login/new.html"

  end

  # SHOW
  get "/:id" do
    erb :"login/show.html"

  end

  # EDIT
  get "/:id/edit" do
    erb :"login/edit.html"

  end

  # CREATE
  post "/" do
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
