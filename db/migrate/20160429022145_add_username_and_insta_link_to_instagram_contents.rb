class AddUsernameAndInstaLinkToInstagramContents < ActiveRecord::Migration
  def change
    add_column :instagram_contents, :username, :string
    add_column :instagram_contents, :insta_link, :string
  end
end
