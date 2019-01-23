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
    if App.correct_form_entry?(params[:specialisation_name]) == true
      specialisation = Specialisation.new
      specialisation.specialisation_id = params[:specialisation_id]
      specialisation.specialisation_name = params[:specialisation_name].strip
      specialisation.save
      redirect "/specialisations"
    else
      @redirect = true
      @specialisation = Specialisation.new
      erb :"specialisations/new.html"
    end

  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i

    if App.correct_form_entry?(params[:specialisation_name]) == true
      specialisation = Specialisation.find id
      specialisation.specialisation_name = params[:specialisation_name].strip
      specialisation.save
      redirect "/specialisations/#{id}"
    else
      @redirect = true
      @specialisation = Specialisation.find id
      erb :"specialisations/edit.html"
    end

  end

  # DESTROY
  delete "/:id" do
    id = params[:id].to_i
    Specialisation.destroy id
    redirect "/specialisations"
  end


end
