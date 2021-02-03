class Publisher < ActiveRecord::Base
  include Slugifiable

  has_many :game_publishers
  has_many :games, through: :game_publishers

  validates :name, presence: true,
                   uniqueness: true
end
