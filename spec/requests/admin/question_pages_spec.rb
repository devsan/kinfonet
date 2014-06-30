require 'spec_helper'

describe "Question pages" do
  subject { page }

  describe "#Create" do
    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:admin) }

    context "before signing in" do
      before { visit admin_root_path }
      
      it "should redirect to sign in page" do
        expect(current_path).to eq(new_user_session_path)
      end
      it { should have_error_message(/You need to sign in/) } 
    end

    context "signed in a non-admin user" do
      before do
        sign_in user, no_capybara: true
        get admin_root_path
      end
     specify { expect(response).to redirect_to(root_url) }

    end
    context 
  end
  
end