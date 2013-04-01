class GraphType < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 32 }


  
  BAR_CHART = GraphType.find_by_name('Bar Chart');
  PIE_CHART = GraphType.find_by_name('Pie Chart');  
  
  
end
