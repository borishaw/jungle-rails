require 'rails_helper'

RSpec.feature "Visitor navigates to login page and input correct login information", type: :feature, js: true do

  # SETUP
  before :each do
    User.create(first_name: 'John',
                last_name: 'Smith',
                email: 'john@smith.com',
                password: 'password',
                password_confirmation: 'password')
  end

  scenario "They will be redirected back to home page" do
    visit '/login'
    fill_in 'email', with: 'john@smith.com'
    fill_in 'password', with: 'password'
    click_on 'Submit'

    expect(page).to have_text 'Signed in as'
    save_screenshot
  end
end
