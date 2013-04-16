# This migration comes from linkifier (originally 0)
class Install < ActiveRecord::Migration
  def change
    create_table :linkifier_resources do |t|
      t.integer :app_resource_id
      t.string :app_resource_type
      t.integer :linkify_resource_id

      t.timestamps
    end
  end
end
