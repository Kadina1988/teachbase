require 'rails_helper'

feature 'User can sign out system' do
  given(:user) { create(:user) }

  background { sign_in(user) }

  scenario 'sign out' do
    visit questions_path
    click_on 'Sign out'

    expect(page).to have_content('Signed out successfully.')
  end
end
