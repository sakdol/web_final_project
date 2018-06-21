class CreateMpcomments < ActiveRecord::Migration
  def change
    create_table :mpcomments do |t|
      t.belongs_to :user
      t.belongs_to :musicpost
      t.text :content
      t.timestamps null: false
    end
  end
end
