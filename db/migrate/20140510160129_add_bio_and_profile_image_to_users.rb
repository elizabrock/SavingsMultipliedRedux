class AddBioAndProfileImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :profile_image, :string
  end
end
