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
        find('#list_title', visible: false).set 'Title'
      end
      click_button 'Create List'
      expect(page).to have_text('Title')
    end
  end
