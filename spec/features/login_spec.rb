require 'spec_helper'

describe 'Login' do
  before { visit '/login' }

  it { page.should have_content 'Sign in' }

  it 'should login using valid credentials' do
    sign_in

    page.should have_content 'John Smith'
    page.should have_content 'Logout'
  end
end
