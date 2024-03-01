require 'rails_helper'

feature 'User can answer question' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background { sign_in(user) }

  scenario 'User create question without errors' do
    visit question_path(question)
    fill_in 'Body', with: 'My answer'
    click_on 'Create answer'

    expect(page).to have_content('Answer successfully created')
    expect(page).to have_content('My answer')
  end
  # scenario 'User create question with errors' do
  #   visit question_path(question)
  #   click_on 'Create answer'

  #   expect(page).to have_content("Body can't be blank")
  # end
end
