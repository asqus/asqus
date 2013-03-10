class StateSenateDistrict < ActiveRecord::Base
  set_primary_keys :state_id, :district 
  has_many :offices, :foreign_key => [ :state_id, :state_senate_district_key]

  belongs_to :state

  attr_accessible :district, :state_id

  validates :state_id, :numericality => { :only_integer => true }
  validates :district, :presence => true
  
  validates_uniqueness_of :district, :scope => :state_id


  def to_s
    return state.name + "state senate district " + district_number.to_s()
  end

end
