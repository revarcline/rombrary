class UserGame < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def created_by=(boolean)
    update(created_by: boolean)
  end
end
