require 'spec_helper'

describe "Quote Pages" do
  subject { page }
  describe "view" do
    let(:quote) { FactoryGirl.create(:quote) }
    before do
      #visit root_path
      #first('.quote-of-the-day p > a').click
      visit quote_path(quote)
    end
    it { p current_path}
    #its(:current_path) {should eq(quote_path(quote_of_the_day))}
    it { should have_title(/Krishnamurti Quote of the Day/) }
    it { should have_selector('h4', /Krishnamurti Quote of the Day/) }

  end

end