class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :gitlab_id
      t.string  :gitlab_url
      t.string  :gitlab_name
      t.timestamps
    end
  end
end
