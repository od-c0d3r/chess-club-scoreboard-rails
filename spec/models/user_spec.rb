require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) {User.new(name: 'Adam', surname:'jack', email: 'adam@jack.com', birthday:'1/1/1990', rank: 1, games_played: 0)}
  
  context 'on creation' do

    it 'should validates presense of name'do
      user.name = nil
      expect(user.save).to be(false)

      user.name = 'Ahmed'
      expect(user.save).to be(true)
    end

    it 'should validates presense of surname'do
      user.surname = nil
      expect(user.save).to be(false)

      user.surname = 'Ahmed'
      expect(user.save).to be(true)
    end

    it 'should validates presense of rank'do
      user.rank = nil
      expect(user.save).to be(false)

      user.rank = 1
      expect(user.save).to be(true)
    end

    it 'should validates presense of games played'do
      user.games_played = nil
      expect(user.save).to be(false)

      user.games_played = 0
      expect(user.save).to be(true)
    end

    it 'should validates presense of birthday'do
      user.birthday = nil
      expect(user.save).to be(false)

      user.birthday = '1/1/1990'
      expect(user.save).to be(true)
    end

    it 'should validates presense of email'do
      user.email = nil
      expect(user.save).to be(false)

      user.email = 'correct@email.com'
      expect(user.save).to be(true)
    end

    it 'should validates uniqnuess of email'do
      user.email = 'same@email.com'
      expect(user.save).to be(true)

      user2 = User.new(name: 'name', surname: 'surname', email: 'same@email.com', birthday: '1/1/1990', games_played: 0, rank: 2)
      expect(user2.save).to be(false)
    end

    it 'should validates age older than 18'do
      user.birthday = '1/1/2010'
      expect(user.save).to be(false)

      user.birthday = '1/1/2000'
      expect(user.save).to be(true)
    end
  end
  
  context 'user helper methods' do
    let(:user1) { User.create!(name: 'Adam', surname:'jack', email: 'adam@jack.com', birthday:'1/1/1990', rank: 1, games_played: 0) }
    let(:user2) { User.create!(name: 'Jone', surname:'jack', email: 'jone@jack.com', birthday:'1/1/1990', rank: 2, games_played: 0) }
    let(:user3) { User.create!(name: 'Dam', surname:'jack', email: 'dam@jack.com', birthday:'1/1/1990', rank: 3, games_played: 0) }

    it 'should get user matches' do
      Match.create!(player_one: user1, player_two: user2, result: 'Draw')
      Match.create!(player_one: user1, player_two: user3, result: 'Draw')
      Match.create!(player_one: user3, player_two: user1, result: 'Draw')

      expect(user1.matches.size).to be(3)
      expect(user2.matches.size).to be(1)
      expect(user3.matches.size).to be(2)
    end

    it 'should capitalize name and surname' do
      user.name = 'lowercasename'
      user.surname = 'lowercasesurname'
      user.save

      expect(user.name).to eq('Lowercasename')
      expect(user.surname).to eq('Lowercasesurname')
    end
  end

  context 'on update' do
    it 'should changes user information' do
      user.save
      expect(user.name).to eq('Adam')

      user.update(name:'Mark')

      expect(user.name).to eq('Mark')
    end
  end
end
