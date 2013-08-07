class ZipCode < ActiveRecord::Base
  belongs_to :state
  belongs_to :municipality, :foreign_key => [:state_id, :municipality_ansi_code]

  def to_s
    return id.to_s
  end
  
  
end

