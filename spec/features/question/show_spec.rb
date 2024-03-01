require 'rails_helper'

feature 'User can to show question and answers', %q{
  On page question
} do
  given(:question) { create(:question) }
  given(:answer) { question.answers.create(body: 'ans')}

  scenario 'User vatching questions and his answers' do
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
  end
end
