require 'rails_helper'

feature 'User can delete only own question' do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'User author' do
    background { sign_in(user) }

    scenario 'Author user' do
      visit question_path(question)
      click_on 'Delete question'

      expect(page).to have_content 'Question was deleted.'
    end
  end

  describe 'Other User tries delete' do
    given(:other_user) { create(:user) }

    background { sign_in(other_user) }

    scenario 'other user' do
      visit question_path(question)
      click_button 'Delete question'

      expect(page).to have_content 'You are not an author'
    end
  end
end
