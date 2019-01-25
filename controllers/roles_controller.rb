class RolesController < AppController

  # INDEX
  get "/" do
    if session[:logged_in] == true
      @roles = Role.all
      erb :"roles/index.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # NEW
  get "/new" do
    if session[:logged_in] == true
      @role = Role.new
      erb :"roles/new.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # SHOW
  get "/:id" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @role = Role.find id
      erb :"roles/show.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # EDIT
  get "/:id/edit" do
    if session[:logged_in] == true
      id = params[:id].to_i
      @role = Role.find id
      erb :"roles/edit.html"
    else
      @not_logged_in = true
      erb :"login/index.html"
    end
  end

  # CREATE
  post "/" do
    if session[:logged_in] == true
      if App.correct_form_entry?(params[:role_name]) == true
        role = Role.new
        role.role_id = params[:role_id]
        role.role_name = params[:role_name].strip
        unique_count = role.unique_count_new "role_table", "role_name", role.role_name

        if unique_count == 0
          role.save
          redirect "/roles"
        else
          @not_unique = true
          @role = Role.new
          erb :"roles/new.html"
        end

      else
        @redirect = true
        @role = Role.new
        erb :"roles/new.html"
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

      if App.correct_form_entry?(params[:role_name]) == true
        role = Role.find id
        role.role_name = params[:role_name].strip
        unique_count = role.unique_count_edit "role_table", "role_name", role.role_name, "role_id", role.role_id

        if unique_count == 0
          role.save
          redirect "/roles/#{id}"
        else
          @not_unique = true
          @role = Role.find id
          erb :"roles/edit.html"
        end

      else
        @redirect = true
        @role = Role.find id
        erb :"roles/edit.html"
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
      if Role.can_destroy?(id) == true
        Role.destroy id
        redirect "/roles"
      else
        @role = Role.find id
        @cannot_delete = true
        erb :"roles/show.html"
      end

    else
      @not_logged_in = true
      erb :"login/index.html"
    end

  end

end
