class AddIndexToUsersLnameFname < ActiveRecord::Migration
  def change
    add_index :users, :lname
    add_index :users, [:fname, :lname]
  end
end
