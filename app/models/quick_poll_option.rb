class QuickPollOption < ActiveRecord::Base
  belongs_to :quick_poll
  attr_accessible :quick_poll_id, :text, :value, :quick_poll_workflow_state_id

  validates :value, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :text, :presence => true, :length => { :minumum => 1, :maximum => 32 }

end
