class UserGame < ActiveRecord::Base
  has_many :games
  has_many :users
end
