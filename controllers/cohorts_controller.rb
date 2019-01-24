class CohortsController < AppController

  # INDEX
  get "/" do
    if session[:logged_in] == true
      @cohorts = Cohort.all
      erb :"cohorts/index.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # NEW
  get "/new" do
    if session[:logged_in] == true
      @cohort = Cohort.new
      erb :"cohorts/new.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # SHOW
  get "/:id" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @cohort = Cohort.find id
      erb :"cohorts/show.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end


  # EDIT
  get "/:id/edit" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @cohort = Cohort.find id
      erb :"cohorts/edit.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # CREATE
  post "/" do
    if session[:logged_in] == true
      if App.correct_form_entry?(params[:cohort_name]) == true
        cohort = Cohort.new
        cohort.cohort_id = params[:cohort_id]
        cohort.cohort_name = params[:cohort_name].strip
        cohort.specialisation_id = params[:specialisation_id]
        cohort.save
        redirect "/cohorts"
      else
        @redirect = true
        @cohort = Cohort.new
        erb :"cohorts/new.html"
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

      if App.correct_form_entry?(params[:cohort_name]) == true
        cohort = Cohort.find id
        cohort.cohort_name = params[:cohort_name].strip
        cohort.specialisation_id = params[:specialisation_id]
        cohort.save
        redirect "/cohorts/#{id}"
      else
        @redirect = true
        @cohort = Cohort.find id
        erb :"cohorts/edit.html"
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
      if Cohort.can_destroy?(id) == true
        Cohort.destroy id
        redirect "/cohorts"
      else
        @cohort = Cohort.find id
        @cannot_delete = true
        erb :"cohorts/show.html"
      end

    else
      @not_logged_in = true
      erb :"login/index.html"
    end

  end

end
