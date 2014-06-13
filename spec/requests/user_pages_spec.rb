require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit sign_up_path }
    it {p sign_up_path}
    it { should have_content('Sign Up') }
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
        fill_in "First Name", with: "Andrea"
        fill_in "Last Name", with: "Singh"
        fill_in "Email", with: "andrea@example.com"
        fill_in "Password", with: "secret"
      end
      it "should change User count by one" do
        expect { click_button submit }.to change(User, :count).by(1)
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
  
  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user, no_capybara: true )
      visit edit_user_path(user)
    end
    #it {p user}
    it { should have_title(/Edit User/) }
    it { should have_content("Update Your Profile") }
    
    context "with invalid information" do
      let(:submit) { "Save Changes" }
      before do
        fill_in "First Name", with: ""
        click_button submit   
      end
      #it {p current_path}
      it { should have_content(/Fname can't be blank/) } 
    end

    context "with valid information" do
      let(:new_fname) { "Frank" }
      let(:new_lname) { "McTester" }
      let(:new_public_comment) {"This is what I think."}
      let(:new_email) {"new@email.com"}
      let(:new_password) {"new_password"}
      let(:submit) { "Save Changes" }
      before do
        fill_in "First Name", with: new_fname
        fill_in "Last Name", with: new_lname
        fill_in "Thoughts/Reflections", with: new_public_comment
        fill_in "Email", with: new_email
        click_button submit
       end
      
      it { should have_selector('.alert.alert-info', text: /Profile updated/)}
      specify {expect(user.reload.fname).to eq new_fname}
      specify {expect(user.reload.lname).to eq new_lname}
      specify {expect(user.reload.public_comment).to eq new_public_comment}
      specify {expect(user.reload.email).to eq new_email}   
    end

  end

  # describe "edit" do
  #   ....
  #   describe "forbidden attributes" do
  #     let(:params) do
  #       { user: { admin: true, password: user.password,
  #                 password_confirmation: user.password } }
  #     end
  #     before do
  #       sign_in user, no_capybara: true
  #       patch user_path(user), params
  #     end
  #     specify { expect(user.reload).not_to be_admin }
  #   end
  # end
  

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      # visit user_path(user)
    end
    #it { p current_path}
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

end
