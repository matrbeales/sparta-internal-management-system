class CohortsController < Sinatra::Base

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
    @cohorts = Cohort.all
    erb :"cohorts/index.html"
  end

  # NEW
  get "/new" do
    # @cohort
    @cohort = Cohort.new
    erb :"cohorts/new.html"
  end

  # SHOW
  get "/:id" do
    id = params[:id].to_i
    @cohort = Cohort.find id

    erb :"cohorts/show.html"
  end

  # EDIT
  get "/:id/edit" do
    # @cohort


    erb :"cohorts/edit.html"
  end

  # CREATE
  post "/" do
    cohort = Cohort.new
    cohort.cohort_id = params[:cohort_id]
    cohort.cohort_name = params[:cohort_name]
    cohort.specialisation_id = params[:specialisation_id]

    cohort.save
    redirect "/cohorts"
  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i
    cohort = Cohort.find id

    cohort.cohort_id = params[:cohort_id]
    cohort.cohort_name = params[:cohort_name]
    cohort.specialisation_id = params[:specialisation_id]

    cohort.save
    redirect "/cohorts/#{id}"
  end

  # DESTROY
  delete "/:id" do
    id = params[:id].to_i
    Cohort.destroy id
    redirect "/cohorts"
  end


end
