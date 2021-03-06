describe "Integration test: Instances Creation", type: :feature do
    context 'creates new match' do
        before :each do
            User.create!(name: 'Adam', surname:'jack', email: 'adam@jack.com', birthday:'1/1/1990', rank: 1, games_played: 0)
            User.create!(name: 'Ahmed', surname:'jack', email: 'ahmed@jack.com', birthday:'1/1/1990', rank: 2, games_played: 0)
        end

        it "shows match details after creation" do
            visit '/matches/new'
            click_button 'Create Match'

            expect(page).to have_content 'prohibited this match from being recorded'

            select('Adam', from: 'match_player_one')
            select('Ahmed', from: 'match_player_two')
            select('Draw', from: 'match_result')

            click_button 'Create Match'

            expect(page).to have_content 'Ranks updated and match successfully recorded.'
        end
    end

    context 'creates new user' do
        it "shows user details after creation" do
            visit '/users/new'
            
            click_button 'Create User'

            expect(page).to have_content 'errors prohibited this user from being saved'

            fill_in('Name', with: 'ahmed')
            fill_in('Surname', with: 'omar')
            fill_in('Email', with: 'omar@omar.com')
            fill_in('Birthday', with: '1/1/2000')

            click_button 'Create User'

            expect(page).to have_content 'User was successfully created.'
            expect(page).to have_content 'Ahmed Omar'
        end
    end
end