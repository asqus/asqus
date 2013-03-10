class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  def to_s
    return "Role: " + name + " on " + resource_type + ":" + resource_id.to_s
  end
  
  scopify
end
