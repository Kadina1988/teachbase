require 'rails_helper'

feature 'User can add answer', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:my_link) { 'yandex.ru' }


  scenario 'User add link' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'body'

    fill_in 'Link name', with: 'yandex'
    fill_in 'Url', with: my_link

    click_on 'Create answer'

    within '.answers' do
      expect(page).to have_link 'yandex', href: my_link
    end
  end

end
