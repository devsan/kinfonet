Given(/^I am a guest$/) do
end

When(/^I fill out registration form with valid data$/) do
  visit '/register'
  fill_in "user_email", with: "user01@email.com"
  fill_in "user_password", with: "pass"
  fill_in "user_password_confirmation", with: "pass"
  click_button "Register"
end