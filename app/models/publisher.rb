class Publisher < ActiveRecord::Base
  include Slugifiable
  has_many :games
end
