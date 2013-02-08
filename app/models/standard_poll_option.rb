class StandardPollOption < ActiveRecord::Base
  belongs_to :standard_poll_option_set
  attr_accessible :standard_poll_option_set_id, :text, :value

  validates :text, :presence => :true
  validates :value, :presence => :true, :numericality => { :only_integer => true }
  
  validates_uniqueness_of :text, :scope => :standard_poll_option_set_id
  validates_uniqueness_of :value, :scope => :standard_poll_option_set_id
  
  validates_associated :standard_poll_option_set

end
