class CreateMplikes < ActiveRecord::Migration
  def change
    create_table :mplikes do |t|

      t.belongs_to :user
      t.belongs_to :musicpost
      t.timestamps null: false
    end
  end
end
