class CreateTeamcomments < ActiveRecord::Migration
  def change
    create_table :teamcomments do |t|
      t.belongs_to :user
      t.belongs_to :team
      t.text :content
      t.timestamps null: false
    end
  end
end
