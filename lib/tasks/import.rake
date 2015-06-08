require 'csv'

desc "Import users, movies from csv file"
task :import => [:environment] do

  file = "movielens-data/user.csv"
  userHeaders = CSV.read(file)[0]

  puts "importing users"
  CSV.foreach(file, :headers => true) do |row|
    rowHash = row.to_hash
    user = User.find_or_create_by(label: rowHash["label"]) do |u|
      u.attributes = rowHash
    end
    user.save!
  end

  file = "movielens-data/item.csv"
  movieHeaders = CSV.read(file)[0]

  puts "importing movies"
  CSV.foreach(file, :headers => true) do |row|
    rowHash = row.to_hash
    movie = Movie.find_or_create_by(movie_id: rowHash["movie_id"]) do |m|
      m.attributes = rowHash
    end
    movie.save!
  end

end
