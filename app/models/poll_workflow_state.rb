class PollWorkflowState < ActiveRecord::Base
  has_many :polls

  def to_s
    return name
  end
end
