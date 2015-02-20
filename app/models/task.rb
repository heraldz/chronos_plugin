class Task < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :task_type, :class_name => "TaskType", :foreign_key => "task_type_id"
  belongs_to :source, :class_name => "Source", :foreign_key => "source_id"
  belongs_to :status, :class_name => "Status"
  belongs_to :role, :class_name => "Role", :foreign_key => "role_id"
  belongs_to :creator, :class_name => "Person", :foreign_key => "created_by"
  
  # Named Scopes
  scope :pending, -> { joins(:status).where("statuses.name = ?", 'pending') }
  scope :newtask, -> { joins(:status).where("statuses.name = ?", 'new') }
  scope :voicemail, -> { joins(:task_type).where("task_types.name = ?", 'Voicemail') }
  scope :broken, -> { joins(:task_type).where("task_types.name = ?", 'Broken Report') }
  scope :idle, -> { joins(:task_type).where("task_types.name = ?", 'Idle Report') }
  scope :unmatched, -> { joins(:task_type).where("task_types.name = ?", 'Unmatched') }
  scope :other, -> { joins(:task_type).where("task_types.name = ?", 'Other Tasks') }
  scope :email_type, -> { joins(:task_type).where("task_types.name = ?", 'email') }
  
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
  
 # def self.search_voicemail(search_voicemail)
#    if search_voicemail
 #     where('title LIKE ?', "%#{search}%").joins(:task_type).where("task_types.name = ?", 'Voicemail')
  #  else
   #   all
   # end
  #end
  

  
  def is_new?
    self.status.name == "new"
  end  
  
  def is_pending?
    self.status.name == "pending"
  end
end