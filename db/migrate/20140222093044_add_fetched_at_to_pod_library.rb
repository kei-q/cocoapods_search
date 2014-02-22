class AddFetchedAtToPodLibrary < ActiveRecord::Migration
  def change
    add_column :pod_libraries, :github_data_fetched_at, :datetime
    add_index :pod_libraries, :github_data_fetched_at
  end
end
