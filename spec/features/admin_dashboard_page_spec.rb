require 'spec_helper'

#https://learn.thoughtbot.com/test-driven-rails-resources/rspec_acceptance.pdf
feature "Dashboard Page", js: true do
  scenario "should not have javascript errors" do
    visit "/admin"
    expect(page).not_to have_errors
  end
end
