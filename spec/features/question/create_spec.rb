require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: 'Some title'
      fill_in 'Body', with: 'Some body text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created'
      expect(page).to have_content 'Some title'
    end

    scenario 'asks a question with errors' do
      click_on 'Ask'
      expect(page).to have_content "Title can't be blank"
    end

    scenario 'asks a question with file' do
      fill_in 'Title', with: 'Some title'
      fill_in 'Body', with: 'Some body text'

      attach_file 'File', ["#{Rails.root}/app/models/user.rb", "#{Rails.root}/app/models/question.rb"]
      click_on 'Ask'

      expect(page).to have_link 'user.rb'
      expect(page).to have_link 'question.rb'
    end
  end

  describe 'Unauthenticate user' do
    scenario ' tries to ask a question' do
      visit questions_path
      click_on 'Ask question'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
