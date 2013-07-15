class PollWorkflowState < ActiveRecord::Base
  has_many :quick_polls
  

  def to_s
    return name
  end
  
  
  
  START = PollWorkflowState.find_by_name('Start');
  APPROVED = PollWorkflowState.find_by_name('Approved');
  PUBLISHED = PollWorkflowState.find_by_name('Published');
  CLOSED = PollWorkflowState.find_by_name('Closed');
  
  
end
