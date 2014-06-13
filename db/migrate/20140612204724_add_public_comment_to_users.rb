class AddPublicCommentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_comment, :text
  end
end
