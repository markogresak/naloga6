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

    ratedMovies = current_user.movies
    unratedMovies = Movie.all - ratedMovies

    knn = []

    puts "total length: #{ratedMovies.size * unratedMovies.size}"

    ratedMovies.each do |ratedMovie|
      ratedMovieUsers = ratedMovie.users
      ratedMovieRatings = ratedMovie.ratings
      unratedMovies.each do |unratedMovie|
        unratedMovieUsers = unratedMovie.users
        unratedMovieRatings = unratedMovie.ratings
        usersRatedBoth = unratedMovieUsers & ratedMovieUsers
        sumBoth = 0
        sumRated = 0
        sumUnrated = 0
        usersRatedBoth.each do |userBoth|
          bothRatings = userBoth.ratings
          avgRating = bothRatings.average(:rating)
          ratedRating = (bothRatings & ratedMovieRatings).first.rating
          unratedRating = (bothRatings & unratedMovieRatings).first.rating
          # or: u.ratings.where(:movie_id => m.ratings)
          ux = (ratedRating - avgRating)
          uy = (unratedRating - avgRating)
          sumBoth += ux * uy
          sumRated += ux * ux
          sumUnrated += uy * uy
        end
        knn.push({movie_id: unratedMovie.id, similarity: sumBoth / Math.sqrt((sumRated * sumBoth).abs) })
      end
    end

    puts knn

    @movies = Movie.limit(5)
    @ratings = Rating.group(:movie_id).average(:rating)

  end

end
