class SpecialisationsController < AppController

  # INDEX
  get "/" do
    @specialisations = Specialisation.all
    erb :"specialisations/index.html"
  end

  # NEW
  get "/new" do
    @specialisation = Specialisation.new
    erb :"specialisations/new.html"
  end

  # SHOW
  get "/:id" do
    id = params[:id].to_i
    @specialisation = Specialisation.find id
    erb :"specialisations/show.html"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id].to_i
    @specialisation = Specialisation.find id
    erb :"specialisations/edit.html"
  end

  # CREATE
  post "/" do


    redirect "/"
  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i
    specialisation = Specialisation.find id

    specialisation.specialisation_name = params[:specialisation_name]

    specialisation.save

    redirect "/specialisations/#{id}"
  end

  # DESTROY
  delete "/:id" do


    redirect "/"
  end


end
