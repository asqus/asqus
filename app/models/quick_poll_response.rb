class QuickPollResponse < ActiveRecord::Base
  belongs_to :quick_poll
  belongs_to :user
  attr_accessible :quick_poll_id, :user_id, :value, :browser_fingerprint, :uid

  validates :quick_poll_id, :presence => true
  validates :user_id, :presence => true
  validates :value, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

end
 