describe "Integration test 2", type: :feature do
    before :each do
        User.create!(name: 'Adam', surname:'jack', email: 'adam@jack.com', birthday:'1/1/1990', rank: 1, games_played: 0)
        User.create!(name: 'Ahmed', surname:'jack', email: 'ahmed@jack.com', birthday:'1/1/1990', rank: 2, games_played: 0)
    end

    context 'high rank player won' do

        it "shows no changes to users ranks" do
            visit '/matches/new'

            select('Adam', from: 'match_player_one')
            select('Ahmed', from: 'match_player_two')
            select('Player 1 Won', from: 'match_result')

            click_button 'Create Match'

            expect(page).to have_content 'Ranks updated and match successfully recorded.'

            visit '/users'

            expect(find('#user_1')).to have_content '#1'
            expect(find('#user_2')).to have_content '#2'
        end
    end

    context 'low rank player won' do
        it 'shows changes to both players ranks' do
            visit '/matches/new'

            select('Adam', from: 'match_player_one')
            select('Ahmed', from: 'match_player_two')
            select('Player 2 Won', from: 'match_result')

            click_button 'Create Match'

            expect(page).to have_content 'Ranks updated and match successfully recorded.'

            visit '/users'

            expect(find('#user_1')).to have_content '#2'
            expect(find('#user_2')).to have_content '#1'
        end
    end
end