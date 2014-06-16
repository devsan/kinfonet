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

class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  validates :country_code, presence: true
  #validates :zip, presence: true
end
