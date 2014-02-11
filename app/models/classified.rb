# == Schema Information
#
# Table name: classifieds
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  content            :text
#  user_id            :integer
#  state              :integer          default(0)
#  url                :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Classified < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order("created_at DESC")}
  validates :name, :content, :user_id, presence: true
end
