require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  let!(:user) { create(:user) }

  feature 'Sign In' do
    background do
      visit root_path
    end

    scenario 'fails with invalid credentials', js: true do
      click_button 'Sign in'
      expect(page).to have_text('incorrect')
    end

    scenario 'success with valid credentials', js: true do
      within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Sign in'
      expect(page).to have_text('Signed in as')
      click_link 'Logout'
      expect(page).to have_text('Login')
    end
  end

  feature 'Sign Up' do
    background do
      visit '/signup'
    end

    scenario 'fails with invalid credentials', js: true do
      click_button 'Create user'
      expect(page).to have_text('Password confirmation')
    end

    scenario 'success with valid credentials', js: true do
      within 'form' do
        fill_in 'Name', with: user.name
        fill_in 'Email', with: 'test.email@test.com'
        fill_in 'Password', with: user.password
        fill_in 'Password confirmation', with: user.password
      end
      click_button 'Create user'
      expect(page).to have_text('You signed up successfully')
    end
  end
end
