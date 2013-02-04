class OfficialTerm < ActiveRecord::Base
  belongs_to :office
  belongs_to :official
  belongs_to :term
  
  attr_accessible :office_id, :official_id, :term_id

  validates :office_id, :presence => :true
  validates :official_id, :presence => :true
  validates :term_id, :presence => :true

end
