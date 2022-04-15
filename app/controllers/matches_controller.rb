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

    respond_to do |format|
      if @match.save
        # update_rank(player_one, player_two, result, @match)
        # update_games_played(player_one, player_two)
        format.html { redirect_to users_path, notice: "Ranks updated and match successfully recorded." }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def match_params
    params.require(:match).permit(:player_one, :player_two, :result)
  end

  def update_rank(player_one, player_two, result, match)
    case result
    when 'Player 1 Wins'
      puts 'n is a perfect square'
    when 'Player 2 Wins'
      puts 'n is a perfect square'
    when "It's a Draw"
      puts 'n is a prime number'
    else
      # render :new, status: :unprocessable_entity    
    end
  end
end
