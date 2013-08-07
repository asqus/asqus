class Ward < ActiveRecord::Base
  belongs_to :municipality, :foreign_key => [:state_id, :municipality_ansi_code]
  attr_accessible :municipality_ansi_code, :ward_number

  validates_presence_of :state_id, :municipality_ansi_code, :ward_number
  validates_numericality_of :ward_number, :only_integer => true, :greater_than => 0
  validates_uniqueness_of :ward_number, :scope=>:municipality_id

  def to_s
   return "Ward " + ward_number.to_s
  end


end
