class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id # 팔로우 한 사람
      t.integer :followed_id # 팔로우 당한 사람
      t.timestamps null: false
    end
    
    add_index :follows, :follower_id
    add_index :follows, :followed_id
    add_index :follows, [:follower_id, :followed_id], unique: true # 중복 팔로우 배제 하기위해서 
    
  end
end
