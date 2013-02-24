class QuickPollType < ActiveRecord::Base
  attr_accessible :type
  validates_presence_of :name
  validates_uniqueness_of :name
  
  
  PUBLIC = QuickPollType.find('PUBLIC')
  PRIVATE = QuickPollType.find('PRIVATE')
  ANONYMOUS = QuickPollType.find('ANONYMOUS')
  
end
