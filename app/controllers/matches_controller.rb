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
          one.rank > two.rank ? upgrade_rank(one) : upgrade_rank(two)
        end
      when 'Player 1 Won'
        if one.rank > two.rank
          jump_rank(one, two)
          downgrade_rank(two)
        end
      when 'Player 2 Won'
        if two.rank > one.rank
          jump_rank(two, one)
          downgrade_rank(one)
        end
      end
  end

  def downgrade_rank(player)
    User.where(:rank => player.rank + 1)[0].update(:rank => player.rank)
    player.update(:rank => player.rank + 1)
  end

  def upgrade_rank(player)
    User.where(:rank => player.rank - 1).update_all(:rank => player.rank)
    player.update(:rank => player.rank - 1)
  end

  def jump_rank(jumper, holder)
    jumper_rank = jumper.rank - ((jumper.rank - holder.rank)/2.0).round()
    until jumper_rank == jumper.rank do
      upgrade_rank(jumper)
    end
  end
end
