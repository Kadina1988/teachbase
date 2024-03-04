require 'rails_helper'

feature 'User can to show question and answers', %q{
  On page question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  background do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content answer.body
  end

  scenario 'Unauthirized User vatching questions and his answers' do;end
end
