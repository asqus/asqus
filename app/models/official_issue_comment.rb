class OfficialIssueComment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :official
  
  attr_accessible :official_id, :issue_id, :comment

end