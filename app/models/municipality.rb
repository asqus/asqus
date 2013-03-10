class Municipality < ActiveRecord::Base
  
  set_primary_keys :state_id, :ansi_code
  has_many :offices, :foreign_key => [ :state_id, :municipality_ansi_code]
  has_many :wards, :foreign_key => [ :state_id, :municipality_ansi_code]
  belongs_to :state
  attr_accessible :name, :state_id

  validates :state_id, :presence => true, :numericality => { :only_integer => true }
  validates :name, :presence => true, :length => { :minimum => 1, :maximum => 32 }

  validates_uniqueness_of :name, :scope => :state_id

  def to_s
    return name + ", " + state.abbreviation
  end

end
