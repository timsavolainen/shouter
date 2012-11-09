class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :email
    	t.string :username
    	t.string :password
    	t.string :profile_bg
    	t.string :profile_fg
    	t.string :profile_image

      t.timestamps
    end
  end
end
