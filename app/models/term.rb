class Term < ActiveRecord::Base
  belongs_to :office_type
  attr_accessible :from_date, :name, :office_type_id, :standard, :to_date

  validates :name, :presence => true
  validates :from_date, :presence => true
  validates :to_date, :presence => true
  

end
