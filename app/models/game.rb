class Game < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_many :users, through: :user_games
  has_many :genres, through: :game_genres
  has_many :regions, through: :game_regions
  belongs_to :console
  belongs_to :publisher
end
