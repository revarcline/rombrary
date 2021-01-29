class User < ActiveRecord::Base
  include Slugifiable
  has_many :user_games
  has_many :games, through: :user_games
  has_secure_password
end
