class CreateAuthorings < ActiveRecord::Migration
  def change
    create_table :authorings do |t|
      t.integer :pod_id, null: false
      t.integer :author_id, null: false
      t.timestamps
    end
  end
end
