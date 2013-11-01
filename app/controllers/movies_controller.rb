class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @movies = Movie.all
    @all_ratings = Movie.movie_ratings
    @ratings_filter = params[:ratings].nil? ?
        (session[:ratings_filter].nil? ? Movie.movie_ratings : session[:ratings_filter]) :
        params[:ratings].keys
    @sort_res_by = params[:sort_by].nil? ?
        (session[:sort_by].nil? ? "" : session[:sort_by]) :
        params[:sort_by]

    if (!params.has_key?(:ratings) || !params.has_key?(:sort_by))
      r = Hash[*@ratings_filter.zip(Array.new(@ratings_filter.length) {'1'}).flatten]
      flash.keep
      redirect_to movies_path(sort_by: @sort_res_by, ratings: r)
    else
      @movies = Movie.find(:all, conditions: ["rating in (?)", @ratings_filter],
                           order: "%{sorting}" % {sorting: @sort_res_by})
      session[:sort_by] = @sort_res_by
      session[:ratings_filter] = @ratings_filter
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
