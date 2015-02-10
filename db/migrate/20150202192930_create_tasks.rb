class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :title
      t.text :email
      t.integer :source_id
      t.integer :task_type_id
      t.references :person_id
      t.integer :status_id
      t.integer :created_by

      t.timestamps null: false
    end
  end
end
