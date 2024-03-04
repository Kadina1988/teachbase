require 'rails_helper'

feature 'User can add link', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do
  given(:user) { create(:user) }
  given(:my_link) { 'yandex.ru' }

  background { sign_in(user) }

  scenario 'User add link' do
    visit new_question_path
    fill_in 'Title', with: 'title'
    fill_in 'Body', with: 'body'
    fill_in 'Link name', with: 'yandex'
    fill_in 'Url', with: my_link
    click_on 'Ask'

    expect(page).to have_link 'yandex', href: my_link
  end

end
