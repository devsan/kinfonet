class AddFeedbackToUsers < ActiveRecord::Migration
  def change
    add_column :users, :feedback, :text
  end
end
