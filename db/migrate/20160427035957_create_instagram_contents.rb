class CreateInstagramContents < ActiveRecord::Migration
  def change
    create_table :instagram_contents do |t|
      t.datetime :created_time
      t.text :caption_text
      t.string :media_url

      t.timestamps null: false
    end
  end
end
