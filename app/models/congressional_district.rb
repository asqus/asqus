class CongressionalDistrict < ActiveRecord::Base
  has_many :offices, :as => :polity
  belongs_to :state

  attr_accessible :district_number, :state_id

  validates :state_id, :presence => :true, :numericality => { :only_integer => true }
  validates :district_number, :presence => :true, :numericality => { :only_integer => true }
  validates_uniqueness_of :district_number, :scope => :state_id
  validates_associated :state

  def to_s
    return state.name + " District " + district_number.to_s()
  end

end
