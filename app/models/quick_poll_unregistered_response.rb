class QuickPollUnregisteredResponse < ActiveRecord::Base
  belongs_to :quick_poll
  attr_accessible :quick_poll_id, :value, :uid

  validates :quick_poll_id, :presence => true
  validates :value, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

end
