require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit sign_in_path }
    
    it { should have_content('Sign in') }
    #it { p current_path}
    it { should have_title(full_title('Sign in')) }
  end

  describe "sign in" do
    before { visit sign_in_path }

    describe "with invalid information" do
      before { click_button("Sign in") }
      
      it { should have_title('Sign in')}
      it { should have_error_message("Invalid") }      
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      it { should_not have_link('Sign in', href: sign_in_path) }
      it { should have_link("Profile", href: user_path(user)) } 
      it { should have_link("Settings", href: edit_user_path(user))}
      it { should_not have_error_message("Invalid") }  
      it { should have_selector('div.alert.alert-info', text: 'Signed in') }
      #it {p current_path}
      
      describe "followed by sign out" do
        before { first(:link, 'Sign out').click }
        it { should have_notice_message('Signed out') }
        it { should have_link('Sign in', href: sign_in_path) }
      end
    end
    
  end # describe 'sign in' page ends

  describe "Authorization" do
    describe "non-signed in user" do
      describe "when attempting to visit a protected page" do
        let(:user) { FactoryGirl.create(:user) }

        before { visit user_path(user) }
        
        it "should redirect to sign in page" do
          # p user_path(user)
          # p current_path
          # p sign_in_path
          #p (current_path == new_user_session_path)
          expect(current_path).to eq(new_user_session_path)
        end
        
        it "should prompt user to sign in" do
          expect(page).to have_error_message('You need to sign in')
        end
        
        describe "after signing in successfully" do
          before { sign_in user }
          it "should redirect user back to requested page" do
            # p current_path
            # p new_user_session_path
            expect(current_path).to eq(user_path(user))         
          end         
        end

      end   
    end

  end # describe Authorization ends

end # describe Authetication ends


  

  


