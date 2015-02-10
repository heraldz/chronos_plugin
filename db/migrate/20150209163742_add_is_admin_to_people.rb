class AddIsAdminToPeople < ActiveRecord::Migration
  def change
    add_column :people, :is_admin, :boolean
  end
end
