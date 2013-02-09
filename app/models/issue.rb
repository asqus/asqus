class Issue < ActiveRecord::Base
  belongs_to :poller, :polymorphic => true
  has_many :polls
  has_many :quick_polls
  has_many :tags, :as => :taggable

  attr_accessible :poller_id, :poller_type, :title, :tag_string, :tags_attributes, :comment
  attr_accessor :tag_string

  validates :title, :presence => true, :length => { :minimum => 3, :maximum => 64 }
  
  accepts_nested_attributes_for :tags, :allow_destroy => true, :reject_if => lambda{ |t| t[:text].blank? }

end
