class AddGitHubRawDataToPodLibrary < ActiveRecord::Migration
  def change
    add_column :pod_libraries, :github_raw_data, :text
    rename_column :pod_libraries, :git_sourcce, :git_source
  end
end
