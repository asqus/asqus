class CongressionalDistrict < ActiveRecord::Base
  set_primary_keys :state_id, :district 
  has_many :offices, :foreign_key => [ :state_id, :congressional_district]
  belongs_to :state

  attr_accessible :district, :state_id

  validates :state_id, :presence => :true, :numericality => { :only_integer => true }
  validates :district, :presence => :true, :numericality => { :only_integer => true }
  validates_uniqueness_of :district, :scope => :state_id
  validates_associated :state

  def to_s
    return state.name + " District " + district.to_s()
  end

end
