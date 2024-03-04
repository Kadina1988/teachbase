require 'rails_helper'

feature 'User can delete files' do
  given(:user) { create(:user) }
  given(:question) { create(:question, :with_files, user: user) }

  background { sign_in(user) }

  scenario 'remove file' do
    visit question_path(question)
    click_button 'remove'

    expect(page).to_not have_content 'user.rb'
  end
end
