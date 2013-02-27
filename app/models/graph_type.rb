class GraphType < ActiveRecord::Base
  attr_accessible :name
  validates :id, :presence => true, :uniqueness => true, :length => { :maximum => 32 }
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 32 }


  
  BAR_CHART = GraphType.find('BAR_CHART');
  PIE_CHART = GraphType.find('PIE_CHART');  
  
  
end
