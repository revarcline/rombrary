class Console < ActiveRecord::Base
  include Slugifiable
  has_many :games
end
