class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :leader_id
      t.integer :post_id
      t.boolean :ongoing, :default => true # true이면 팀원 신청 받는중, false이면 팀원 신청 마감.
      t.timestamps null: false
    end
  end
end
