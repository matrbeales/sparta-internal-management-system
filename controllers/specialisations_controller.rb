class SpecialisationsController < AppController

  # INDEX
  get "/" do
    if session[:logged_in] == true
      @specialisations = Specialisation.all
      erb :"specialisations/index.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # NEW
  get "/new" do
    if session[:logged_in] == true
      @specialisation = Specialisation.new
      erb :"specialisations/new.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # SHOW
  get "/:id" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @specialisation = Specialisation.find id
      erb :"specialisations/show.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # EDIT
  get "/:id/edit" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @specialisation = Specialisation.find id
      erb :"specialisations/edit.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # CREATE
  post "/" do
    if session[:logged_in] == true
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

    else
      @not_logged_in = true
      erb :"login/index.html"
    end

  end

  # UPDATE
  put "/:id" do
    if session[:logged_in] == true
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

    else
      @not_logged_in = true
      erb :"login/index.html"
    end

  end

  # DESTROY
  delete "/:id" do
    if session[:logged_in] == true
      id = params[:id].to_i
      Specialisation.destroy id
      redirect "/specialisations"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end


end
