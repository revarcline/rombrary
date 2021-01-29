class GameRegion < ActiveRecord::Base
  belongs_to :game
  belongs_to :region
end
