class GamePublisher < ActiveRecord::Base
  belongs_to :game
  belongs_to :publisher
end
