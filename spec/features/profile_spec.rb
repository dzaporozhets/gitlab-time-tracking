require 'spec_helper'

describe 'Login' do
  before {
    sign_in
    visit '/profile'
  }

  it { page.should have_content 'Hi, John Smith' }
  it { page.should have_content 'GitLab profile' }
end
