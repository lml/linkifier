class CreateDummyResources < ActiveRecord::Migration
  def change
    create_table :dummy_resources do |t|
      t.string :name
      t.string :url
      t.boolean :is_permalink
      t.integer :resource_type

      t.timestamps
    end
  end
end
