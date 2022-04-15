class User < ApplicationRecord
  def matches
    get_matchs_as_player_one(self).compact.concat(get_matchs_as_player_two(self))
  end

  private

  def get_matchs_as_player_one(player)
    Match.where(player_one:player)
  end

  def get_matchs_as_player_two(player)
    Match.where(player_two:player)
  end
end
