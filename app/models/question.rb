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

class Question < ActiveRecord::Base
end
