class MoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    @ratings = Rating.group(:movie_id).average(:rating)
  end

  def rate
    @rate = Rating.update_or_create(movie_id: params[:movie_id], user_id: current_user.id, rating: params[:rating])

    if @rate.save
      render :nothing => true, :status => 204
    else
      render :nothing => true, :status => 400
    end
  end

  def top

    ratedMovies = current_user.movies
    unratedMovies = Movie.all - ratedMovies

    knn = []

    puts "total length: #{ratedMovies.size * unratedMovies.size}"

    ratedMovies.each do |ratedMovie|
      if knn.size >= 5
        break
      end
      ratedMovieUsers = ratedMovie.users
      ratedMovieRatings = ratedMovie.ratings
      unratedMovies.each do |unratedMovie|
        if knn.size >= 5
          break
        end
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
        k = sumBoth / Math.sqrt((sumRated * sumBoth).abs)
        if k.abs > 0.6
          knn.push(unratedMovie.id)
        end
      end
    end

    puts knn

    @movies = Movie.find(knn)
    # @ratings = Rating.group(:movie_id).average(:rating)

  end

  def topfast

    # unratedMovies = Movie.all - current_user.movies
    topRatings = Rating.group(:movie_id).average(:rating).sort_by { |id, value| value }.reverse
    @movies = Movie.find(topRatings.take(5).map {|r| r.first})
    # movieIds = []
    # i = 0
    # while movieIds.length < 5
    #   value = unratedMovies.find(topRatings[i].first).first
    #   if value
    #     movieIds.push(i + 1)
    #   end
    #   i += 1
    # end
    #
    # @movies = Movie.find(movieIds)
  end

end
