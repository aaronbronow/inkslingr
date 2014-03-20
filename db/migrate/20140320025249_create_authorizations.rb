class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.integer :member_id
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
