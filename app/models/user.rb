class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications, :dependent => :delete_all
  has_many :groups, :through => :user_groups
  belongs_to :site_role
  belongs_to :staff_official, :class_name => :Official
  belongs_to :municipality, :foreign_key => [:state_id, :municipality_ansi_code]
  belongs_to :county, :foreign_key => [:state_id, :county_ansi_code]
  belongs_to :congressional_district, :foreign_key => [:state_id, :congressional_district]
  
  attr_accessible :role_ids, :as => :admin
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :current_location, :birth_date, :sex
  attr_accessible :state_id, :congressional_district_no, :county_ansi_code, :municipality_ansi_code
  attr_accessible :state_house_district_key, :state_senate_district_key

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

end
