require 'spec_helper'

describe 'Login' do
  before { visit '/login' }

  it { page.should have_content 'Sign in' }

  it 'should login using valid credentials' do
    fill_in 'user_session_email', with: 'test@test.com'
    fill_in 'user_session_password', with: '123456'
    fill_in 'user_session_url', with: 'http://demo.gitlab.com'
    click_button "Sign in"

    page.should have_content 'John Smith'
    page.should have_content 'Logout'
  end
end
