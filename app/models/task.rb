class Task < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :task_type, :class_name => "TaskType", :foreign_key => "task_type_id"
  belongs_to :source, :class_name => "Source", :foreign_key => "source_id"
  belongs_to :status, :class_name => "Status", :foreign_key => "status_id"
  belongs_to :role, :class_name => "Role", :foreign_key => "role_id"
  belongs_to :creator, :class_name => "Person", :foreign_key => "created_by"
  
  
  #def self.import(file)
  #  CSV.foreach(file.path, headers: true) do |row|    
  #    task = find_by_id(row["id"]) || new
  #    task.attributes = row.to_hash.slice(*row.to_hash.keys)
  #    task.save!
  #  end
  #end
  
  def self.import(file, creator_id, task_type_id, person_id)    
    CSV.foreach(file.path, headers: true) do |row|
      Task.create! row.to_hash.merge(source_id: 2, status_id: 1, created_by: creator_id, task_type_id: task_type_id, person_id: person_id, imported: 1)
    end
  end   
  
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end
  
  def is_new?
    self.status.name == "new"
  end  
  
  def is_pending?
    self.status.name == "pending"
  end
  

end

