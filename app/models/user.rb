class User < ApplicationRecord
  before_save :capitalize_names
  
  validates_presence_of :name
  validates_presence_of :surname
  validates_presence_of :rank
  validates_presence_of :games_played
  validates_presence_of :birthday
  validates :email   , presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :birthday, comparison: { less_than: 18.years.ago, message: "Must be older than 18"}
  
  def matches
    get_matchs_as_player_one(self).compact.concat(get_matchs_as_player_two(self))
  end

  private
  def capitalize_names
    self.name.capitalize!
    self.surname.capitalize!
  end

  def get_matchs_as_player_one(player)
    Match.where(player_one:player)
  end

  def get_matchs_as_player_two(player)
    Match.where(player_two:player)
  end
end
