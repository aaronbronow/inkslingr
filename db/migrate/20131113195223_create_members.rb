class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :twitter_id
      t.string :screen_name
      t.string :token
      t.string :secret
      t.string :profile_image_url

      t.timestamps
    end
  end
end
