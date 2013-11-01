class Movie < ActiveRecord::Base
  MOVIE_RATINGS = ['G','PG','PG-13','R']
  def self.movie_ratings
      MOVIE_RATINGS
  end
end
