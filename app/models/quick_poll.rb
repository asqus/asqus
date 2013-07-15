class QuickPoll < ActiveRecord::Base

  belongs_to :poll_workflow_state
  belongs_to :issue
  belongs_to :quick_poll_type
  belongs_to :graph_type

  has_many :quick_poll_options
  has_many :quick_poll_responses
  has_many :official_mailings, :through => :quick_poll_mailings

  attr_accessible :body, :end_time, :issue_id, :poll_workflow_state_id, :start_time, :title
  attr_accessible :quick_poll_type_id, :quick_poll_options_attributes, :poller_type, :poller_id
  attr_accessible :graph_type_id
  attr_accessor :poller_type, :poller_id 

  accepts_nested_attributes_for :quick_poll_options, :allow_destroy => true, :reject_if => lambda { |o| o[:text].blank? }

  validates_presence_of :issue, :quick_poll_type, :end_time, :start_time, :graph_type
  validates_associated :quick_poll_type, :poll_workflow_state, :issue
  
  validates :title, :presence => true, :length => { :minimum => 3, :maximim => 64 }
  validates :body, :presence => true, :length => { :minimum => 3, :maximum => 256 }

  def to_s
    return title
  end

public
 

  

  def self.get_unnotified_polls_for_official(official_id)

    return QuickPoll.where("poll_workflow_state_id = ? and start_time < ? and end_time > ? and
                              issue_id in (select id from issues where poller_type = 'Office' and poller_id in (select office_id from incumbents where official_id = ?)) and
                              not exists (select * from quick_poll_mailings where quick_poll_id = quick_polls.id)",
             PollWorkflowState::PUBLISHED, Time.now(),Time.now(), official_id)
    
    
  end
  
  
end
