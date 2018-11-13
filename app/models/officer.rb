class Officer < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  include AppHelpers::Validations

  # Relationships
  belongs_to :unit
  belongs_to :user
  has_many :assignments
  has_many :investigations, through: :assignments
  has_many :investigation_notes

  # Scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :for_unit, -> (unit_id){ where(unit_id: unit_id) }
  scope :detectives, -> { where('rank LIKE ?', "%detective%") }
  scope :search, ->(term) { where('first_name LIKE ? OR last_name LIKE ?', "#{term}%", "#{term}%") }
  
  # Validations
  validates_presence_of :first_name, :last_name, :user_id, :unit_id, :ssn
  validates_format_of :ssn, with: /\A\d{3}[- ]?\d{2}[- ]?\d{4}\z/, message: "should be 9 digits and delimited with dashes only"
  validates_uniqueness_of :ssn
  validates_inclusion_of :rank, in: %w[Officer Sergeant Detective Detective\ Sergeant Lieutenant Captain Commissioner], message: "is not an option"
  validate :unit_is_active_at_gcpd

  # Other methods and callbacks
  before_save :reformat_ssn
  before_save :remove_assignments_from_inactive_officer

  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end
  
  def current_assignments
    current = self.assignments.select{|a| a.end_date.nil?}
    return nil if current.empty?
    current
  end

  # Callbacks
  before_update :deactive_user_if_officer_inactive
  before_update :remove_assignments_from_inactive_officer

  before_destroy do 
    check_if_ever_given_an_assignment
    if errors.present?
      @destroyable = false
      throw(:abort)
    end
  end
 
  after_rollback :convert_to_inactive_and_remove_open_assignments

  RANKS_LIST = [['Officer', 'Officer'],['Sergeant', 'Sergeant'],['Detective', 'Detective'],['Detective Sergeant', 'Detective Sergeant'],['Lieutenant', 'Lieutenant'],['Captain', 'Captain'],['Commissioner', 'Commissioner']]

  private
  def reformat_ssn
    ssn = self.ssn.to_s      # change to string in case input as all numbers 
    ssn.gsub!(/[^0-9]/,"")   # strip all non-digits
    self.ssn = ssn           # reset self.ssn to new string
  end

  def unit_is_active_at_gcpd
    is_active_in_system(:unit)
  end

  def check_if_ever_given_an_assignment
    unless self.assignments.empty?
      errors.add(:base, "Officer cannot be deleted because of previous assignments, but officer status has been set to inactive.")
    end
  end

  def convert_to_inactive_and_remove_open_assignments
    if !@destroyable.nil? && @destroyable == false
      self.make_inactive
      remove_assignments_from_inactive_officer
    end
    @destroyable = nil
  end

  def remove_assignments_from_inactive_officer
    return true if self.active 
    self.assignments.current.each do |assignment|
      assignment.end_date = Date.current
      assignment.save
    end
  end

  def deactive_user_if_officer_inactive
    if !self.active && !self.user.nil?
      self.user.make_inactive
    end
  end
end
