require 'rails_helper'

feature 'User can registration' do
  scenario 'registration' do
    visit new_user_registration_path

    fill_in 'Email', with: 'first@mail.com'
    fill_in 'Password', with: 'ramazan'
    fill_in 'Password confirmation', with: 'ramazan'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
