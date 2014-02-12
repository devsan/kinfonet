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

class Quote < ActiveRecord::Base
  validates :content, 
            :source_location, :source_detail, presence: true
  validates :phrase,  presence:true, 
                      uniqueness: { case_sensitive: false }
end
