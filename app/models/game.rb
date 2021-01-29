class Game < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_many :users, through: :user_games
  has_many :genres, through: :game_genres
  belongs_to :console
  belongs_to :publisher
end
