class GameRegion < ActiveRecord::Base
  has_many :games
  has_many :regions
end
