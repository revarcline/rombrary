class Genre < ActiveRecord::Base
  include Slugifiable
  has_many :game_genres
  has_many :games, through: :game_genres
end
