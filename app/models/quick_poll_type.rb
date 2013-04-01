class QuickPollType < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  
  PUBLIC = QuickPollType.find_by_name('Public')
  PRIVATE = QuickPollType.find_by_name('Private')
  ANONYMOUS = QuickPollType.find_by_name('Anonymous')
  
end
