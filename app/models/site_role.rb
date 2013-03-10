class SiteRole < ActiveRecord::Base
  has_many :users
  
  def to_s
    return self.id
  end

  USER = SiteRole.find('USER')
  ADMIN = SiteRole.find('ADMIN')
  
end
