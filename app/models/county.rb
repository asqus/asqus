class County < ActiveRecord::Base
  set_primary_keys :state_id, :ansi_code
  has_many :offices, :foreign_key => [ :state_id, :county_ansi_code]
  belongs_to :state
  
  attr_accessible :name, :state_id

  validates :state_id, :presence => true, :numericality => { :only_integer => true }
  validates :name, :presence => true, :length => { :maximum => 32 }
  validates_uniqueness_of :name, :scope => :state_id

  def to_s
    return name + " County, " + state.name
  end

end
