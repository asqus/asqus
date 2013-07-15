class QuickPollMailing < ActiveRecord::Base

  belongs_to :quick_poll
  belongs_to :official_mailing

end
