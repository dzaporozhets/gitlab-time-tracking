class CreateTimeLog < ActiveRecord::Migration
  def change
    create_table :time_logs do |t|
      t.float :time
      t.text :comment
      t.integer :issue_iid
      t.integer :project_id
      t.timestamps
    end
  end
end
