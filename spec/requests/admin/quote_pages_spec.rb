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
      let(:submit) { "Create Quote"}
      before do
        sign_in admin
        visit new_admin_quote_path
      end
      it { should have_selector('h2', text: 'New Quote') }
      it { should have_title(full_title('New Quote')) }

      describe "with invalid information" do
        it "should not create a Quote" do
          expect { click_button submit }.not_to change(Quote, :count)       
        end        
      end

      describe "with valid information" do
        before do
          fill_in "Highlighted Phrase", with: "Speculation is a hindrance."
          fill_in "Quote Body", with: "Lorem Ipsum"
          fill_in "Source Location", with: "Ojai CA"
          fill_in "Source Detail", with: "5th Public Talk, 1946"
        end
        it "should create a Quote" do
          expect { click_button submit }.to change(Quote, :count).by(1)
        end
        describe "after saving quote" do
          before { click_button submit }
          let(:quote) { Quote.find_by(phrase: "Speculation is a hindrance.") }    
          it "should be on admin/quote show template" do
            expect(current_path).to eq(admin_quote_path(quote))
          end
          
          it { should have_content(/Ojai CA/) }
          it { should have_title(/Quote of the Day/) }
          it { should have_notice_message(/Quote was successfully created/) }
          it { should have_link('Edit this quote', href: edit_admin_quote_path(quote)) }
        end
      end

    end #after signing in as admin
     
  end
  describe "edit" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:quote) { FactoryGirl.create(:quote) }
    before do
      sign_in admin
      visit edit_admin_quote_path(quote)
    end
    
    describe "page" do
      it { should have_title("Edit Quote") }
      it { should have_content("Update Quote") }
    end

    describe "with invalid information" do
      before do
        fill_in "Highlighted Phrase", with: ""
        click_button "Save Changes"
      end
      it { should have_content(/Whoops! Looks like there's a problem./) }
    end

    describe "with valid information" do
      let(:new_phrase) { "New Phrase" }
      let(:new_content) { "New Content" }
      before do
        fill_in "Highlighted Phrase", with: new_phrase
        fill_in "Quote Body", with: new_content
        click_button "Save Changes"
      end
      it "should be redirect to admin/quote show" do
        expect(current_path).to eq(admin_quote_path(quote))
      end
      it { should have_content(/New Content/) }
      it { should have_title(/Quote of the Day/) }
      it { should have_notice_message(/Quote was successfully updated/) }
      specify { expect(quote.reload.phrase).to eq new_phrase }
    end
  end #edit page

  describe "delete" do
    let(:admin) { FactoryGirl.create(:admin) }
    let(:quote) { FactoryGirl.create(:quote) }
    before do
      sign_in admin
      visit admin_quote_path(quote)
    end
      it { should have_link('Delete', href: admin_quote_path(quote)) }
      it "should delete quote" do
        expect do
          click_link('Delete', match: :first)
        end.to change(Quote, :count).by(-1)
      end
  end
end