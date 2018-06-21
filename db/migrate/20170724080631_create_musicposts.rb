class CreateMusicposts < ActiveRecord::Migration
  def change
    create_table :musicposts do |t|
      t.string :title
      t.string :musictype
      t.string :content
      t.string :music
      t.string :image
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
