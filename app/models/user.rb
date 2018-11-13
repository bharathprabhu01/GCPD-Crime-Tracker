class User < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods

  has_secure_password

  # Relationships
  has_one :officer

  # Validations
  # make sure required fields are present
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :password, :on => :create 
  validates_presence_of :password_confirmation, :on => :create 
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, :minimum => 4, message: "must be at least 4 characters long", :allow_blank => true
  validates_inclusion_of :role, in: %w( commish chief officer ), message: "is not recognized in the system"
  
  # Other methods
  # -----------------------------  
  # for use in authorizing with CanCan
  ROLES = [['Commissioner', :commish],['Unit Chief', :chief],['Officer', :officer]]

  def role?(authorized_role)
    return false if role.nil?
    role.downcase.to_sym == authorized_role
  end
  
  # login by username (Not tested in phase 4)
  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end

end
