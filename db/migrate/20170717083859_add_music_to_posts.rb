class AddMusicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :music, :string
  end
end
