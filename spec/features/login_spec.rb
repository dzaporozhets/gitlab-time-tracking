require 'spec_helper'

describe 'Login' do
  before { visit '/login' }

  it { page.should have_content 'Sign in' }
end
