require 'csv'

desc "Import users, movies from csv file"
task :import => [:environment] do

  file = "movielens-data/user.csv"
  puts "importing users"
  CSV.foreach(file, :headers => true) do |row|
    rowHash = row.to_hash
    user = User.find_or_create_by(label: rowHash["label"]) do |u|
      u.attributes = rowHash
    end
    user.save!
  end

  file = "movielens-data/item.csv"
  puts "importing movies"
  CSV.foreach(file, :headers => true) do |row|
    puts "\tfor movie #{$. - 1}"
    (0..18).each do |i|
      if row[i].to_i == 1
        movieGenre = MovieGenre.find_or_create_by(movie_id: $. - 1, genre_id: i + 1)
        movieGenre.save!
      end
    end
    rowHash = row.drop(19).map{ |pair| Hash[*pair] }.inject{ |h1,h2| h1.merge(h2){ |*a| a[1,2] } }
    movie = Movie.find_or_create_by(movie_id: rowHash["movie_id"]) do |m|
      m.attributes = rowHash
    end
    movie.save!
  end

  file = "movielens-data/data.csv"
  puts "importing ratings"
  CSV.foreach(file, :headers => false) do |row|
    puts "\tfor userid #{$.}"
    row.each_with_index do |col, i|
      ratingValue = col.to_i
      if ratingValue > 0
        rating = Rating.find_or_create_by(movie_id: i + 1, user_id: $.) do |r|
          r.rating = ratingValue
        end
        rating.save!
      end
    end
  end

  file = "movielens-data/genre.csv"
  puts "importing genres"
  CSV.foreach(file, :headers => true) do |row|
    genreName = row.to_hash["genre"]
    genre = Genre.find_or_create_by(name: genreName) do |g|
      g.name = genreName
    end
    genre.save!
  end

end
