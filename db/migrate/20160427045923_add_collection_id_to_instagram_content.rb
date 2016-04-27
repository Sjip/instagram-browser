class AddCollectionIdToInstagramContent < ActiveRecord::Migration
  def change
    add_column :instagram_contents, :collection_id, :integer
    add_index :instagram_contents, :collection_id
  end
end
