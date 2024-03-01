require 'rails_helper'

feature 'User can delete only own question' do
  given(:user) { create(:user) }

  background { sign_in(user) }
  given(:question) { user.questions.create(title: 'Question', body: 'My question') }

  scenario 'delete question' do
    visit question_path(question)
    click_on 'Delete Question'

    expect(page).to have_content('Question was deleted.')
  end

  scenario "can't delete other question" do

  end
end
