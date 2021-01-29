class Region < ActiveRecord::Base
  include Slugifiable
  has_many :game_regions
  has_many :games, through: :game_regions
end
