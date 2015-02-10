class FixPersonFieldInTask < ActiveRecord::Migration
  def change
    rename_column :tasks, :person_id_id, :person_id
  end
end
