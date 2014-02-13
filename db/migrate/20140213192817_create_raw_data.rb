class CreateRawData < ActiveRecord::Migration
  def change
    create_table :raw_data do |t|
      t.references :pod_library
      t.text :github_raw_data

      t.timestamps
    end

    add_index :raw_data, :pod_library_id
  end
end
