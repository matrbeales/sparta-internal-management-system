class RolesController < AppController

  # INDEX
  get "/" do
    @roles = Role.all
    erb :"roles/index.html"
  end

  # NEW
  get "/new" do
    # @role


    erb :"roles/new.html"
  end

  # SHOW
  get "/:id" do
    # @role


    erb :"roles/show.html"
  end

  # EDIT
  get "/:id/edit" do
    # @role


    erb :"roles/edit.html"
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
