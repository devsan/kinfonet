class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.boolean :enabled, default: false
      t.integer :position

      t.timestamps
    end
  end
end
