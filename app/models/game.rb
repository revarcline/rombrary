class Game < ActiveRecord::Base
  has_many :user_games
  has_many :game_genres
  has_many :game_regions
  has_many :users, through: :user_games
  has_many :genres, through: :game_genres
  has_many :regions, through: :game_regions
  belongs_to :console
  belongs_to :publisher

  validates :name, presence: true
end
