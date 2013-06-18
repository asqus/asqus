class SiteRole < ActiveRecord::Base
  has_many :users
  
  def to_s
    return self.id
  end

  USER = SiteRole.find_by_name('User')
  ADMIN = SiteRole.find_by_name('Admin')
  
end
