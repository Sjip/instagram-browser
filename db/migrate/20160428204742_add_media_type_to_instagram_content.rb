class AddMediaTypeToInstagramContent < ActiveRecord::Migration
  def change
    add_column :instagram_contents, :media_type, :string
  end
end
