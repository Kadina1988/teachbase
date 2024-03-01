require 'rails_helper'

feature 'User can show questions list'do
  given(:user) { create(:user) }

  scenario 'Unauthenticate user show questions' do
    visit questions_path
    expect(page).to have_content('All questions:')
  end

  scenario 'Authenticate user show questions' do
    sign_in(user)
    visit questions_path
    expect(page).to have_content('All questions:')
  end
end
