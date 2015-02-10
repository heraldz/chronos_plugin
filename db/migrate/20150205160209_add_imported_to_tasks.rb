class AddImportedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :imported, :boolean
  end
end
