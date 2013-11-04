require 'spec_helper'

describe "Classified pages" do
  subject { page }

  describe "Create page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit new_classified_path }
    
    describe "with non-signed user" do
      it "should redirect user to sign in page" do
        expect(current_path).to eq(new_user_session_path)
      end
      it { should have_error_message('You need to sign in') }     
    end
    describe "after sign in" do
      before { sign_in user }
      it "should redirect back to create page" do
        expect(current_path).to eq(new_classified_path)
      end    
    end #non signed in user

    


    
  end
  
end