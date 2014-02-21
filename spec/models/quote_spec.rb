# == Schema Information
#
# Table name: quotes
#
#  id               :integer          not null, primary key
#  phrase           :string(255)
#  content          :text
#  display_date     :date
#  source_detail    :string(255)
#  source_location  :string(255)
#  source_venue     :string(255)
#  source_date      :date
#  publication_name :string(255)
#  publication_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Quote do
  let(:quote) { FactoryGirl.build(:quote) } 
  subject { quote }

  it { should respond_to(:phrase) }
  it { should respond_to(:content) }
  it { should respond_to(:display_date) }
  it { should respond_to(:source_detail) }
  it { should respond_to(:source_location) }
  it { should respond_to(:source_venue) }
  it { should respond_to(:source_date) }
  it { should respond_to(:publication_name) }
  it { should respond_to(:publication_type) }

  it { should be_valid }

  describe "when phrase not present" do
    before { quote.phrase = " "}
    it { should_not be_valid }
  end
  
  describe "when content not present" do
    before { quote.content = " "}
    it { should_not be_valid }
  end

  describe "when source_location not present" do
    before { quote.source_location = " "}
    it { should_not be_valid }
  end

  describe "when source_detail not present" do
    before { quote.source_detail = " "}
    it { should_not be_valid }
  end

  describe "when phrase is already taken" do
    before do
      quote_with_same_phrase = quote.dup
      quote_with_same_phrase.phrase = quote.phrase.upcase
      quote_with_same_phrase.save
    end
    it { should_not be_valid }
  end
end

