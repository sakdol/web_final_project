class CreateTeammembers < ActiveRecord::Migration
  def change
    create_table :teammembers do |t|
      t.integer :member_id
      t.boolean :granted , :default => false # 팀원 승인 여부
      t.boolean :waiting ,:default => true # 승인 대기중 여부 .1이면 현재 대기중. 0이면 승인 혹은 거절을 한 상태임.
      t.belongs_to :team
      
      t.timestamps null: false
    end
  end
end
