class RenameColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :start, :started_at
    rename_column :events, :end, :end_at
    change_column :events, :started_at, :datetime
    change_column :events, :end_at, :datetime
  end
end
