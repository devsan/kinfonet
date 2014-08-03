require 'spec_helper'

#https://learn.thoughtbot.com/test-driven-rails-resources/rspec_acceptance.pdf
feature "Dashboard Page Home", js: true do
  scenario "#home should not have javascript errors" do
    visit "/admin"
    expect(page).not_to have_errors
  end
end

feature "Dashboard Page Questions", js: true do
  scenario "#home should not have javascript errors" do
    visit "/admin/#questions"
    expect(page).not_to have_errors
  end
end
