class SpecialisationsController < Sinatra::Base

  # Fixes reloader
  configure :development do
    register Sinatra::Reloader
  end

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

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
