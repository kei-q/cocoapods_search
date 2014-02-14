class SetDefaultToPodLibrary < ActiveRecord::Migration
  def change
    change_column :pod_libraries, :github_watcher_count, :integer, default: 0, null: false
    change_column :pod_libraries, :github_stargazer_count, :integer, default: 0, null: false
    change_column :pod_libraries, :github_fork_count, :integer, default: 0, null: false
    change_column :pod_libraries, :github_contributor_count, :integer, default: 0, null: false
    change_column :pod_libraries, :score, :integer, default: 0, null: false
    add_index :pod_libraries, :github_contributor_count
    add_index :pod_libraries, :github_stargazer_count
    add_index :pod_libraries, :last_committed_at
  end
end
