class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :screen_name
      t.integer :member_id
      
      t.timestamps
    end
  end
end
