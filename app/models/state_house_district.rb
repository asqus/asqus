class StateHouseDistrict < ActiveRecord::Base
  has_many :offices, :as => :polity
  belongs_to :state

  attr_accessible :district_number, :state_id

  validates :state_id, :numericality => { :only_integer => true }
  validates :district_number, :numericality => { :only_integer => true }
  
  validates_uniqueness_of :district_number, :scope => :state_id

  def to_s
    return state.name + " state house district " + district_number.to_s()
  end

end
