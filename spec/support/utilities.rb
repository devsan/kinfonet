include Devise::TestHelpers
#http://www.schneems.com/post/15948562424/speed-up-capybara-tests-with-devise/
include Warden::Test::Helpers
Warden.test_mode!

def full_title(page_title)
  base_title = "Krishnamurti Information Network"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

# def sign_in(user, options={})
#   if options[:no_capybara]
#     login_as(user, :scope => :user)
#   else 
#     visit sign_in_path
#     fill_in "Email",    with: user.email
#     fill_in "Password", with: user.password
#     click_button "Sign in"
#   end
# end

def sign_in(user, options={})
   current_user = user || Factory.create(:user)
  if request.present?
    sign_in(current_user)
  else
    login_as(current_user, :scope => :user)
  end
end


RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define :have_notice_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-info', text: message)
  end
end