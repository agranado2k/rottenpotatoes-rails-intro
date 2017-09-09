class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @ratings = params[:ratings] || session[:ratings]
    @filter = params[:filter] || session[:filter]
    
    if (params[:filter].nil? && !params[:ratings].nil?) || (params[:ratings].nil? && !params[:filter].nil?)
      flash.keep
      redirect_to movies_path(filter: @filter, ratings: @ratings)
    end
    
    @all_ratings = Movie.ratings
    
    session[:ratings] = @ratings
    session[:filter] = @filter
    
    @movies = @ratings.nil? ? Movie.all : Movie.where(rating: @ratings.keys)
    @movies = @filter.nil? ? @movies : @movies.order(@filter.to_sym)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
