class Person < ActiveRecord::Base
  has_many :tasks
  belongs_to :role, :class_name => "Role", :foreign_key => "role_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :validatable
                  
  def is_admin?
    self.is_admin == true
  end
  
  def is_supervisor?
    self.role.name == "supervisor"  
  end
  
  def is_agent?
    self.role.name == "agent"
  end 
  
end
