class Office < ActiveRecord::Base
  belongs_to :polity, :polymorphic => true
  belongs_to :office_type
  has_many :officials, :through => :official_tenures
  has_many :users, :through => :user_groups, :as => :group
  has_many :issues, :as => :poller

  attr_accessible :name, :office_type_id, :polity_id, :polity_type, :timestamps

  validates :office_type_id,:presence => true, :numericality => { :only_integer => true }
  validates :polity_type, :presence => true
  validates :polity_id, :presence => true, :numericality => { :only_integer => true }

  validates_associated :office_type, :polity
  
  default_scope :order => "polity_type, polity_id, office_type_id, seat_discriminator"

  def full_name
    self.office_type.name
  end

end
