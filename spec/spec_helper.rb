ENV['RACK_ENV'] = 'test'
require 'capybara'
require 'capybara/dsl'

require_relative '../app'
Capybara.app = GitLabTimeTracking

module Helpers
  def sign_in
    visit '/login'
    fill_in 'user_session_email', with: 'test@test.com'
    fill_in 'user_session_password', with: '123456'
    fill_in 'user_session_url', with: 'http://demo.gitlab.com'
    click_button "Sign in"
  end
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.include Capybara
  config.include Helpers
end
