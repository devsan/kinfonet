require 'spec_helper'

describe "Question pages" do
  subject { page }

  describe "Create Action" do 
    let(:admin) { FactoryGirl.create(:admin) }
    before do
      sign_in(admin, no_capybara: true)
      visit new_admin_question_path
    end

    it { should have_selector("h2", text: "New Question") } 
    it { should have_title(full_title("New Question")) }
 
    context "with invalid information" do
      let(:submit) { "Create Question" }
      it "should not create a Question" do
        expect { click_button submit }.not_to change(Quote, :count)
      end  
    end
  end
  
end