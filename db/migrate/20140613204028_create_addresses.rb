class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, index: true
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state_code
      t.string :country_code
      t.string :zip
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
