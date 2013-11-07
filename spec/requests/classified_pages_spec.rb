require 'spec_helper'

describe "Classified pages" do
  subject { page }

  describe "Create page" do
    let(:user) { FactoryGirl.create(:user) }
    
    describe "before signing in" do
      before { visit new_classified_path }
      it "should redirect user to sign in page" do
        expect(current_path).to eq(new_user_session_path)
      end
      it { should have_error_message('You need to sign in') }     
    
    end

    describe "after signing in" do
      let(:submit) { "Create my classified" }
      before do
        sign_in user
        visit new_classified_path
      end
      it "should redirect back to create page" do
        expect(current_path).to eq(new_classified_path)
      end
      #it { p current_path }
      it { should have_selector('h2', text: 'New Classified') }
      it { should have_title(full_title('New Classified')) }
      
      describe "with invalid information" do
        it "should not change Classified count" do
          expect { click_button submit }.not_to change(Classified, :count)
        end  
      end

      describe "with valid information" do
        before do
          fill_in "Name", with: "Bristol Meeting"
          fill_in 'Content', with: 'Hello world.'
        end
        it "should change Classified count by one" do
          expect { click_button submit }.to change(Classified, :count).by(1)
        end
      end

    end #describe after sign in

  end # create page describe ends
end