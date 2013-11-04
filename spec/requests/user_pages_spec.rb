require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit sign_up_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do
    let(:submit) { "Create my account" }
    before { visit sign_up_path }
    
    describe "with invalid information" do
      it "should not change User count" do
        expect { click_button submit }.not_to change(User, :count) 
      end 
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Andrea Singh"
        fill_in "Email", with: "andrea@example.com"
        fill_in "Password", with: "secret"
      end
      it "should change User count by one" do
        expect {click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "andrea@example.com") }
        
        it { should have_content("Sign out") }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-info', text: 'Welcome') }
      end
    
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit user_path(user)
    end
    #it { p current_path}
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

end
