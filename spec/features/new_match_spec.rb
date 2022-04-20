describe "Integration tests", type: :feature do
    context 'creates new match' do
        it "shows match details after creation" do
            
            visit '/matches/new'
            click_button 'Create Match'

            expect(page).to have_content 'prohibited this match from being recorded'

            select('John', from: 'match_player_one')
            select('Tory', from: 'match_player_two')
            select('Draw', from: 'match_result')
            
            click_button 'Create Match'

            expect(page).to have_content 'Ranks updated and match successfully recorded.'
        end
    end
end