class ZipCode < ActiveRecord::Base

  belongs_to :state
  belongs_to :postal_city, :foreign_key => [:state_id, :postal_city_name]

  def to_s
    return id.to_s
  end
  
  
end

