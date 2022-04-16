class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
    @users = User.all
  end

  def create
    player_one = User.find(match_params["player_one"])
    player_two = User.find(match_params["player_two"])
    result = match_params["result"]
    
    @match = Match.new(player_one:player_one, player_two:player_two, result:result)
    @users = User.all

    if @match.save
      update_players_info(@match)
      redirect_to users_path, notice: "Ranks updated and match successfully recorded."
    else
      render :new, status: :unprocessable_entity
    end

  end

  private

  def match_params
    params.require(:match).permit(:player_one, :player_two, :result)
  end

  def update_players_info(match)
    update_games_played(match.player_one)
    update_games_played(match.player_two)
    update_rank(match)
  end

  def update_games_played(player)
    User.where(:id => player.id).update_all(:games_played => player.matches.length)
  end

  def update_rank(match)
    one = match.player_one
    two = match.player_two
    result = match.result

    case result
      when 'Draw'
        if (-1..1).exclude?(one.rank - two.rank)
          if one.rank > two.rank
            User.where(:rank => one.rank - 1).update_all(:rank => one.rank)
            User.where(:id => one.id).update_all(:rank => one.rank - 1)
          else 
            User.where(:rank => two.rank - 1).update_all(:rank => two.rank)
            User.where(:id => two.id).update_all(:rank => two.rank - 1)
          end 
        end
      when 'Player 1 Won'
        if one.rank > two.rank
          User.where(:rank => two.rank + 1).update_all(:rank => two.rank)
          User.where(:id => two.id).update_all(:rank => two.rank + 1)

          update_following_ranks( one.rank - ((one.rank - two.rank)/2), one.rank)
          User.where(:id => one.id).update_all(:rank => one.rank - (one.rank - two.rank)/2)
        end
      when 'Player 2 Won'
        if two.rank > one.rank
          User.where(:rank => one.rank + 1).update_all(:rank => one.rank)
          User.where(:id => one.id).update_all(:rank => one.rank + 1)
            
          update_following_ranks( two.rank - ((two.rank - one.rank)/2), two.rank)
          User.where(:id => two.id).update_all(:rank => two.rank - (two.rank - one.rank)/2)
        end
      end
  end

  def update_following_ranks(start, last)
    User.where(id: (start..last)).to_a.each do |user|
      User.where(id: user.id).update_all(:rank => user.rank + 1)
    end
  end
end
