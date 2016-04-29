class ChangeFormatOfDatesInCollection < ActiveRecord::Migration
  def up
    change_column :collections, :start_date, :datetime
    change_column :collections, :end_date, :datetime
  end

  def down
    change_column :collections, :start_date, :date
    change_column :collections, :end_date, :date
  end
end
