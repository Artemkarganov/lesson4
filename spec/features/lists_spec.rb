require 'rails_helper'

RSpec.feature 'List', type: :feature do
  let!(:user) { create(:user) }

  feature 'Create' do
    scenario 'success with valid credentials', js: true do
      visit root_path
      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Sign in'
      click_link 'Lists'

      within 'form' do
        fill_in 'list[title]', with: 'Title'
      end
      click_button 'Create List'
      expect(page).to have_text('Title')
    end
  end
    #feature 'Delete' do
    #  scenario 'deletion of the created list', js: true do
    #  visit root_path
    #  within 'form' do
    #    fill_in 'Email', with: user.email
    #    fill_in 'Password', with: user.password
    #  end
    #  click_button 'Sign in'
#
    #  click_link 'Lists'
    #  find('.delete', visible: false).trigger(:click)
    #  expect(page).to have_selector('.delete', visible: true)
    #  click_link('×')
    #end
    #end
end
