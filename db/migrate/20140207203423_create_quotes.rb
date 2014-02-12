class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :phrase
      t.text :content
      t.date :display_date
      t.string :source_detail
      t.string :source_location
      t.string :source_venue
      t.date :source_date
      t.string :publication_name
      t.string :publication_type

      t.timestamps
    end
    add_index :quotes, :display_date
  end
end
