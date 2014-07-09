require 'spec_helper'

feature "Question View", js: true do
  scenario "#questions" do
    visit "#questions"
    expect(page).not_to have_errors
  end
end