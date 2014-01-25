require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "should have the content 'Kinfonet'" do
      #visit '/static_pages/home'
      visit root_path
      expect(page).to have_content('Kinfonet')
    end

    it "should have the right title" do
      visit root_path
      #expect(page).to have_content('Krishnamurti Information Network | Home')
      expect(page).to have_title('Krishnamurti Information Network | Home')
    end
  end
end
