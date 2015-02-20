class Status < ActiveRecord::Base
  has_many :task
  
  def is_new?
    self.name == "new"
  end  
  
  def is_pending?
    self.name == "pending"
  end
  
end
