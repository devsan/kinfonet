require "spec_helper"

describe "Quote pages" do
 subject { page }

  describe "Create Quote" do
    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:admin) }

    describe "before signing in" do
      before { visit new_admin_quote_path }
      it "should redirect user to sign in page" do
        expect(current_path).to eq(new_user_session_path)
      end

      it { should have_error_message(/You need to sign in/) }
    end

    describe "when signed in as regular user" do
      before do
        sign_in user
        visit new_admin_quote_path  
      end
      it "should redirect to home page" do
        expect(current_path).to eq(root_path)
      end
      it { should have_error_message('You must be an admin to do that.') }
    end

    describe "when admin is not yet signed in" do
      before do
        visit new_admin_quote_path 
        fill_in "Email", with: admin.email
        fill_in "Password", with: admin.password
        click_button("Sign in")

      end
      it "should redirect to new admin quote page after sucessful sign in" do
        expect(current_path).to eq(new_admin_quote_path)
      end
    end

    describe "after signing in as admin" do
      let(:submit) { "Create Quote" }
      before do
        sign_in admin
        visit new_admin_quote_path   
      end
      #it { p current_path }
      it { should have_selector('h2', text: 'New Quote') }
      it { should have_title(full_title('New Quote')) }
      
      describe "with invalid information" do
        it "should not change the Quotes count" do
          expect { click_button submit }.not_to change(Quote, :count) 
        end
      end

      describe "with valid information" do
        before do
          fill_in "Highlighted Phrase", with: "Speculation is a hindrance to understanding."
          fill_in "Quote Body", with: "Lorem Ipsum"
          fill_in "Source Location", with: "Ojai CA"
          fill_in "Source Detail", with: "5th Public Talk, 1946"
        end
        

        it "should change the Quotes count by one" do
          expect { click_button submit }.to change(Quote, :count).by(1)
        end        
      end
    end
     
  end
end