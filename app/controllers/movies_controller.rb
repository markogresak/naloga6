class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    @ratings = Rating.group(:movie_id).average(:rating)
  end

  def rate
    @rate = Rating.create(movie_id: params[:movie_id], user_id: current_user.id, rating: params[:rating])

    if @rate.save
      render :nothing => true, :status => 204
    else
      render :nothing => true, :status => 400
    end
  end

  def top

    # magic
    # ...

    @movies = Movie.limit(5)
    @ratings = Rating.group(:movie_id).average(:rating)

  end

end
