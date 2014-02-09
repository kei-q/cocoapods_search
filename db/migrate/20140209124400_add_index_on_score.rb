class AddIndexOnScore < ActiveRecord::Migration
  def change
    add_index :pod_libraries, :score
  end
end
