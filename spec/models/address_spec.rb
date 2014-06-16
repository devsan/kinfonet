# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  addressable_id   :integer
#  addressable_type :string(255)
#  address1         :string(255)
#  address2         :string(255)
#  city             :string(255)
#  state_code       :string(255)
#  country_code     :string(255)
#  zip              :string(255)
#  lat              :float
#  lng              :float
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'
  
describe "User Address" do
  let(:user) { FactoryGirl.create(:user) }
  let(:address) { FactoryGirl.create(:address, addressable: user) }
  subject { address }
  it { p address } 
  it { should be_valid }
end


