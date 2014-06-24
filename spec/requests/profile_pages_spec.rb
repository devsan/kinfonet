require 'spec_helper'

describe "Profile Pages" do
  subject { page }

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user, no_capybara: true)
      visit edit_profile_path(user)
    end
    it { should have_title(/Edit Profile/) } 
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
      let(:submit) { "Save Changes" }
      before do
        fill_in "First Name", with: new_fname
        fill_in "Last Name", with: new_lname
        fill_in "About You", with: new_public_comment
        click_button submit
       end
      
      it { should have_selector('.alert.alert-info', text: /Profile updated/)}
      specify {expect(user.reload.fname).to eq new_fname}
      specify {expect(user.reload.lname).to eq new_lname}
      specify {expect(user.reload.public_comment).to eq new_public_comment} 
    end

  end

  
end