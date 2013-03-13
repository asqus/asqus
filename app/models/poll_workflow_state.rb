class PollWorkflowState < ActiveRecord::Base
  has_many :polls
  attr_accessible :description

  def to_s
    return name
  end
end
