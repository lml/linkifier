class Install < ActiveRecord::Migration
  def change
    create_table :linkifier_resources do |t|
      t.integer :app_resource_id
      t.string :app_resource_type
      t.integer :linkify_resource_id

      t.timestamps
    end

    add_index :linkifier_resources, [:app_resource_id, :app_resource_type],
              :name => "index_linkifier_r_on_app_r_id_and_app_r_type",
              :unique => true
    add_index :linkifier_resources, :linkify_resource_id, :unique => true
  end
end
