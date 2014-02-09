class CreatePodLibraries < ActiveRecord::Migration
  def change
    create_table :pod_libraries do |t|

      t.timestamps
    end
  end
end
