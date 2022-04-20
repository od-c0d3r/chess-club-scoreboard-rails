require 'rails_helper'

RSpec.describe Match, type: :model do
  fixtures :users

  context 'on creation' do
    let(:player_one) {users(:p1)}
    let(:player_two) {users(:p2)}

    it 'should validate players must be differnet' do
      player_two = users(:p1)

      match = Match.new(player_one: player_one, player_two: player_two, result: 'Draw')
      expect(match.save).to be(false)

      player_two = users(:p2)
      match.player_two = player_two
      expect(match.save).to be(true)
    end

    it 'should validates presence of results' do
      match = Match.new(player_one: player_one, player_two: player_two)
      expect(match.save).to be(false)
    end
  end
end
