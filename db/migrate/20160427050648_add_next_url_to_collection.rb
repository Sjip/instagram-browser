class AddNextUrlToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :next_url, :string
  end
end
