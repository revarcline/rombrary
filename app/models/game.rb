class Game < ActiveRecord::Base
  has_many :user_games
  has_many :game_genres
  has_many :game_regions
  has_many :game_publishers
  has_many :users, through: :user_games
  has_many :genres, through: :game_genres
  has_many :regions, through: :game_regions
  has_many :publishers, through: :game_publishers
  belongs_to :console

  validates :name, presence: true

  def created_by=(user)
    ug = UserGame.where(user_id: user.id, game_id: id)
    ug.update(created_by: true)
    @created_by = user
  end

  def created_by
    User.find(UserGame.where(game_id: id, created_by: true)[0].user_id)
  end

  def created_by?(user)
    created_by == user
  end
end
