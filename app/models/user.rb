class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications, :dependent => :delete_all
  belongs_to :site_role
  belongs_to :staff_official, :class_name => :Official
  belongs_to :rep_state, :class_name => 'State', :foreign_key => :rep_state_id
  belongs_to :rep_municipality, :class_name => 'Municipality', :foreign_key => [:rep_state_id, :rep_municipality_ansi_code]
  belongs_to :rep_county, :class_name => 'County', :foreign_key => [:rep_state_id, :rep_county_ansi_code]
  belongs_to :rep_congressional_district, :class_name => 'CongressionalDistrict', :foreign_key => [:rep_state_id, :rep_congressional_district_no]
  belongs_to :rep_state_house_district, :class_name => 'StateHouseDistrict', :foreign_key => [:rep_state_id, :rep_state_house_district_key]
  belongs_to :rep_state_senate_district, :class_name => 'StateSenateDistrict', :foreign_key => [:rep_state_id, :rep_state_senate_district_key]
  
  attr_accessible :role_ids, :as => :admin
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :current_location, :birth_date, :sex, :latitude, :longitude
  attr_accessible :rep_congressional_district_no, :rep_county_ansi_code, :rep_municipality_ansi_code
  attr_accessible :rep_state_house_district_key, :rep_state_senate_district_key, :rep_ward_key
  attr_accessible :address1, :address2, :city, :zip, :rep_state_id

  include ActiveModel::Validations

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors.add attribute, (options[:message] || "is not an email") unless
        value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    end
  end

  validates :first_name, :presence => true, :length => { :minimum => 1, :maximum => 20 }
  validates :last_name, :presence => true, :length => { :minimum => 2, :maximum => 20 }
  validates :email, :presence => true, :uniqueness => true, :email => true, :length => { :maximum => 255 }

  before_create :default_values
  def default_values
    if self.site_role_id.nil?
      self.site_role_id = SiteRole::USER.id
    end
    @facebook = nil
  end

  def apply_omniauth(auth)
    info = auth['extra']['raw_info']
    self.email = info['email']
    self.first_name = info['first_name']
    self.last_name = info['last_name']
    # self.sex = info['sex']
    # self.current_location = info['current_location']
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end  

  def get_offices
    return Office.where("id in (select group_id from user_groups where group_type = 'Office' and user_id = ?)", id)
  end
  
  def name
    return first_name + " " + last_name
  end


  def self.send_thanks_for_voting_email(user_id)
    
    user = User.find(user_id)
    if user.nil?
      logger.error "send_thanks_for_voting_email could not find user id " + user_id.to_s
    else
      UserMailer.thanks_for_voting_email(user).deliver
    end
           
  end

  #
  # Facebook-API-related functions
  # 
  
  def facebook
    logger.debug "User::facebook called"
    if @facebook.nil?
      logger.debug "User::facebook @facebook is nill, trying to find token"
      facebook_token = nil
      authentications.each do |auth|
        if auth.provider == 'facebook'
          facebook_token = auth.token
        end
      end  
      if facebook_token.nil?
        logger.debug "User::facebook failed to find find auth token"
      else        
        logger.debug "User::facebook auth token found, creating connection"
        @facebook ||= Koala::Facebook::API.new(facebook_token)
      end

    end
    
    return @facebook

  end
  
  def get_facebook_permissions
    logged.debug "User::get_facebook_permissions called"
    perms = nil
    fb = facebook
    unless fb.nil?
      perms = fb.get_connection("me","permissions") 
    end
    return perms   
  end
  
  def post_to_facebook_wall(message)
  logger.debug "User::post_to_facebook_wall called"
    fb = facebook
    unless fb.nil?
      logger.debug "User::post_to_facebook_wall found connection, posting to wall"
      fb.put_wall_post(message)
    end
  rescue
    logger.debug "Exception in User::post_to_facebook_wall"   
  end
  
 

  
end
