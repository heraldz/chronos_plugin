class AddResolvedAtToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :resolved_at, :datetime
  end
end
