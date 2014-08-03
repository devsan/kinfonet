require 'spec_helper'

feature "Questions View", js: true, :type => :feature do
  before :each do
    Question.create!(:name => 'One', enabled:true )
    Question.create!(:name => 'Two', enabled: true)
  end
  scenario "#questions" do
    visit "admin/#questions"
    expect(page).not_to have_errors
  end
end