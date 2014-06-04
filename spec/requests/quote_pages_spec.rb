require 'spec_helper'

describe "Quote Pages" do
  
  subject { page }
  
  describe "view" do
    let(:quote) { FactoryGirl.create(:quote, display_date: Date.today) }
    
    let!(:prev_quote) { FactoryGirl.create(:quote, display_date: Date.today - 1.day) }
    
    let!(:next_quote) { FactoryGirl.create(:quote, display_date: Date.today + 1.day) }
    before do
      #visit root_path
      #first('.quote-of-the-day p > a').click
      visit quote_path(quote)
    end
    it { p next_quote}
    #its(:current_path) {should eq(quote_path(quote_of_the_day))}
    it { should have_title(/Krishnamurti Quote of the Day/) }
    it { should have_selector('h4', /Krishnamurti Quote of the Day/) }
    it { should have_link('previous quote', href: quote_path(prev_quote)) }
    it { should_not have_link('next quote', href: quote_path(next_quote)) }
    it { should have_selector('span.text-muted', text:'next quote') } 

    describe "next quote link" do
      before { click_link 'previous quote' }
        it { should have_link('next quote', href: quote_path(quote)) }
    end

  end

end