class MailingStatus < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 32 }
  has_many :official_mailings


  INITIAL = MailingStatus.find_by_name('Initial');
  READY = MailingStatus.find_by_name('Ready');
  SENDING = MailingStatus.find_by_name('Sending');
  COMPLETE = MailingStatus.find_by_name('Complete');
  ERROR = MailingStatus.find_by_name('Error');  
  
  
end
