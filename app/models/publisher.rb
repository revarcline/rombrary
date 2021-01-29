class Publisher < ActiveRecord::Base
  include Slugifiable
  has_many :games, through: :game_genres
end
