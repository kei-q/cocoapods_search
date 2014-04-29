class CreateAuthorings < ActiveRecord::Migration
  def change
    create_table :authorings do |t|

      t.timestamps
    end
  end
end
