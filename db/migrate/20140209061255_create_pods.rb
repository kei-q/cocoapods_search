class CreatePods < ActiveRecord::Migration
  def change
    create_table :pods do |t|
      t.string :name
      t.string :homepage
      t.string :social_media_url
      t.string :documentation_url

      t.string :summary
      t.text :description

      t.string :git_sourcce
      t.string :git_tag

      t.string :current_version
      t.datetime :current_version_released_at
      t.datetime :first_version_released_at

      t.integer :github_watcher_count
      t.integer :github_stargazer_count
      t.integer :github_fork_count
      t.integer :github_contributor_count

      t.datetime :first_committed_at
      t.datetime :last_committed_at
      t.text :recent_commits

      t.timestamps
    end
  end
end
