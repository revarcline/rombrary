class GameGenre < ActiveRecord::Base
  has_many :games
  has_many :genres
end
