class CreateClassifieds < ActiveRecord::Migration
  def change
    create_table :classifieds do |t|
      t.string :name
      t.text :content
      t.references :user, index: true
      t.integer :state, default: 0
      t.string :url
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size

      t.timestamps
    end
    add_index :classifieds, [:user_id, :created_at]
    add_index :classifieds, [:user_id, :state, :created_at]
  end
end
