class Official < ActiveRecord::Base
  has_many :offices, :through => :official_tenures
  has_many :users, :through => :user_groups, :as => :group
  has_many :official_issue_comments
  belongs_to :party

  attr_accessible :email, :first_name, :middle_name, :last_name, :photo

  validates :first_name, :presence => true, :length => { :minimum => 1, :maximum => 20 } 
  validates :last_name, :presence => true, :length => { :minimum => 1, :maximum => 20 }  
  validates :middle_name, :length => { :maximum => 20 }
  validates :nickname, :length => { :maximum => 20 }
  validates :name_suffix, :length => { :maximum => 20 }
  validates :gender, :length => { :maximum => 1 }
  validates :phone, :length => { :maximum => 20 }
  validates :email, :length => { :maximum => 256 } 
  validates :website, :length => { :maximum => 256 } 
  validates :webform, :length => { :maximum => 256 } 
  validates :twitter_id, :length => { :maximum => 64 } 
  validates :congresspedia_url, :length => { :maximum => 256 } 
  validates :youtube_url, :length => { :maximum => 256 } 
  validates :facebook_id, :length => { :maximum => 64 } 
  validates :fax, :length => { :maximum => 20 } 
  validates :votesmart_id, :numericality => { :only_integer => :true }
  validates :govtrack_id, :numericality => { :only_integer => :true }
  validates :bioguide_id, :length => { :maximum => 32 } 
  validates :eventful_id, :length => { :maximum => 32 } 
  validates :official_rss, :length => { :maximum => 256 } 
  validates :photo_extension, :length => { :maximum => 20 } 


  after_save :store_photo
    
  def has_photo?
    File.exists? photo_filename
  end
  
  def photo=(file_data)
    unless file_data.blank?
      @file_data = file_data
      self.photo_extension = file_data.original_filename.split('.').last.downcase
    end
  end

  OFFICIAL_PHOTO_STORE = File.join Rails.root, 'public', 'official_photo_store'
  
  def photo_filename
    File.join OFFICIAL_PHOTO_STORE, "#{id}.#{photo_extension}"
  end
  
  def photo_path
    "/official_photo_store/#{id}.#{photo_extension}"
  end
  
  def name
    self.first_name + " " + self.last_name
  end

private

  def store_photo
    if @file_data
      # if photo directory doesn't exist, make it
      FileUtils.mkdir_p OFFICIAL_PHOTO_STORE
      File.open(photo_filename, 'wb') do |f|
        f.write(@file_data.read)
      end
      @file_data = nil # file save only once
    end
  end


  

  

end
