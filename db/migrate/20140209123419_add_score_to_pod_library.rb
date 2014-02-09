class AddScoreToPodLibrary < ActiveRecord::Migration
  def change
    add_column :pod_libraries, :score, :integer
  end
end
