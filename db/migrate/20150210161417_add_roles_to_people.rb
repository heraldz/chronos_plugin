class AddRolesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :role_id, :int
  end
end
