class PostalCity < ActiveRecord::Base
  set_primary_keys :state_id, :name
  
  belongs_to :state
  has_many :zip_codes
   

end