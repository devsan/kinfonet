# == Schema Information
#
# Table name: classifieds
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  user_id            :integer
#  url                :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe "Classified" do
  let(:user) { FactoryGirl.create :user }
  before do 
    @classified = user.classifieds.build(name: "Bristol Meeting", content: "Hello world.")
  end
  subject { @classified }

  it { should respond_to(:name) }
  it { should respond_to(:content) }
  it { should respond_to(:url) }
  #it { should respond_to(:image_file_name) }
  #it { should respond_to(:image_content_type) }
  #it { should respond_to(:image_file_size) }
  
  #user association
  it { should respond_to(:user) }
  its(:user) { should eq user}

  describe "when name is not present" do
    before { @classified.name = "" }
    it { should_not be_valid }  
  end

  describe "when content is not present" do
    before { @classified.content = "" }
    it { should_not be_valid }  
  end

  describe "when user_id is not present" do
    before { @classified.user_id = nil }
    it { should_not be_valid }  
  end
  
end
