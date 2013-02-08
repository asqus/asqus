class Tag < ActiveRecord::Base
  belongs_to :taggable, :polymorphic => true
  attr_accessible :context, :tag, :taggable_id, :taggable_type

  #validates :tag, :presence => true, :length => { :minimum => 1, :maximum => 32 }
  #validates :context, :length => { :maximum => 32 }
  #validates :taggable_type, :presence => true
  #validates :taggable_id, :presence => true, :numericality => { :only_integer => true }

end
