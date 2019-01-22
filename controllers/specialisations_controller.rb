class SpecialisationsController < AppController

  # INDEX
  get "/" do
    # @specialisations


    erb :"specialisations/index.html"
  end

  # NEW
  get "/new" do
    # @specialisation


    erb :"specialisations/new.html"
  end

  # SHOW
  get "/:id" do
    # @specialisation


    erb :"specialisations/show.html"
  end

  # EDIT
  get "/:id/edit" do
    # @specialisation


    erb :"specialisations/edit.html"
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
