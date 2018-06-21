class AddImageToUsersAndPosts < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :posts, :image, :string
  end
end
