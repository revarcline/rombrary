class Console < ActiveRecord::Base
  include Slugifiable

  has_many :games

  validates :name, presence: true,
                   uniqueness: true
end
