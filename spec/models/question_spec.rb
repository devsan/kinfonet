# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  enabled    :boolean          default(FALSE)
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe "Question" do
  before do
    @question = Question.new(name: "First Question")
  end

  subject { @question }

  it { should respond_to(:name) } 
  it { should respond_to(:enabled) } 
  it { should respond_to(:position) } 
  
end
