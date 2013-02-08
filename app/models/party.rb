class Party < ActiveRecord::Base

  validates :name, :presence => true, :length => { :maximum => 32 }
  validates :member_noun, :presence => true, :length => { :maximum => 32 }
  validates :abbreviation, :presence => true, :length => { :maximum => 1 }
  
end
