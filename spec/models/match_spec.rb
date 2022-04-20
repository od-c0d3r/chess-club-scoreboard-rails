require 'rails_helper'

RSpec.describe Match, type: :model do
  before :each do
      User.create!(name: 'Adam', surname:'jack', email: 'adam@jack.com', birthday:'1/1/1990', rank: 1, games_played: 0)
      User.create!(name: 'Ahmed', surname:'jack', email: 'ahmed@jack.com', birthday:'1/1/1990', rank: 2, games_played: 0)
  end
  context 'on creation' do

    it 'should validate players must be differnet' do

      match = Match.new(player_one: User.first, player_two: User.first, result: 'Draw')
      expect(match.save).to be(false)

      match.player_two = User.second
      expect(match.save).to be(true)
    end

    it 'should validates presence of results' do
      match = Match.new(player_one: User.first, player_two: User.second)
      expect(match.save).to be(false)
    end
  end
end
