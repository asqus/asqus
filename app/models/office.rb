class Office < ActiveRecord::Base
  belongs_to :office_type
  belongs_to :state
  belongs_to :congressional_district, :foreign_key => [:state_id, :congressional_district_no]
  belongs_to :state_senate_district, :foreign_key => [:state_id, :state_senate_district_key]
  belongs_to :state_house_district, :foreign_key => [:state_id, :state_house_district_key]
  belongs_to :county, :foreign_key => [:state_id, :county_ansi_code]
  belongs_to :municipality, :foreign_key => [:state_id, :municipality_ansi_code]
  belongs_to :ward, :foreign_key => [:state_id, :municipality_ansi_code, :ward]
  
  
  has_many :officials, :through => :official_terms
  has_many :incumbent_officials, :class_name => "Official", :through => :incumbents
  has_many :users, :through => :user_groups, :as => :group
  has_many :issues, :as => :poller
  has_many :joined_official_terms
  has_many :incumbents

  attr_accessible :name, :office_type_id, :timestamps

  validates :office_type_id,:presence => true 

  validates_associated :office_type
  
  default_scope :order => "state_id, office_type_id, congressional_district_no, state_senate_district_key, state_house_district_key"

  def full_name
    self.office_type.name
  end
  
  def self.incumbent_official(office_id)  
    return Official.where("id in (select official_id from official_terms o, terms t where o.term_id = t.id and o.office_id = ? and t.from_date <= now() and t.to_date >= now())", office_id).first
  end
    
  def self.check_staff_permission(office_id, official_id)
    incumbent = Incumbent.find_by_office_id(office_id)
    return official_id == incumbent.official_id
  end
    

  def get_constituents(mailable_only=true)
    users = []
    mailable_sql = ""
 
    if mailable_only
      mailable_sql = " and email is not null and email_kill_switch = false"
    end
      
   case office_type.id
      when OfficeType::US_SENATOR.id, OfficeType::GOVERNOR.id
        logger.debug "get_all_constituents for a governor or US senator"
        users = User.where("rep_state_id = ?" + mailable_sql,@state_id)
      when OfficeType::US_REP.id
        logger.debug "get_all_constituents for a US representative"
        users = User.where("rep_state_id = ? and rep_congressional_district_no = ?" + mailable_sql, state.id, congressional_district_no)
      when OfficeType::STATE_SENATOR.id
        logger.debug "get_constituents for a state senator"
        users = User.where("rep_state_id = ? and rep_state_senate_district_key = ? + mailable_sql", state.id, state_senate_district_key)
      when OfficeType::STATE_REP.id
        logger.debug "get_constituents for a state representative"
        users = User.where("rep_state_id = ? and rep_state_house_district_key = ? + mailable_sql", state.id, state_house_district_key)
      else
        logger.debug "send_notification incumbent is an invalid official type"
    end
    
    return users
    
  end
    
  
    
    


end
