class CreateLinkifierLinkifyResources < ActiveRecord::Migration
  def change
    create_table :linkifier_linkify_resources do |t|
      t.integer :resource_id
      t.string :resource_type
      t.integer :linkify_resource_id

      t.timestamps
    end
  end
end
