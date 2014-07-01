require 'spec_helper'

describe "  Dashboard Page" do
  subject {page}

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  context "before signing in" do
    before { get admin_root_path }
    specify { expect(response.body).not_to match(full_title("Dashboard")) }
    specify {expect(response).to redirect_to(new_user_session_path)} 
  end

  context "signed in as regular user" do
    before do
      sign_in(user, no_capybara: true)
      get admin_root_path
    end
    specify { expect(response.body).not_to match(full_title("Dashboard")) }
    specify {expect(response).to redirect_to(root_path)} 
  end

  context "signed in as admin" do
    before do
      sign_in(admin, no_capybara: true)
      visit admin_root_path
    end
    specify { expect(page).to have_title(full_title("Dashboard")) }
    specify {expect(page).to have_link("New Question", href: new_admin_question_path)}
  end

  
end