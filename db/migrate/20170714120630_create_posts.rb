class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :musictype
      t.string :content
      t.string :requirement
      t.belongs_to :user
      t.timestamps null: false
    end
  end
  
  
end
