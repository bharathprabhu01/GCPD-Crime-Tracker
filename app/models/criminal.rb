class Criminal < ApplicationRecord
  # Relationships
  has_many :suspects
  has_many :investigations, through: :suspects

  # Scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :prior_record, -> { where(convicted_felon: true) }
  scope :enhanced, -> { where(enhanced_powers: true) }
  scope :search, ->(term) { where('first_name LIKE ? OR last_name LIKE ? OR aka LIKE ?', "#{term}%", "#{term}%", "%#{term}%") }
  
  # Validations
  validates_presence_of :first_name, :last_name

  # Other methods and callbacks
  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end

  before_destroy do 
    check_if_convicted_felon
    check_if_has_enhanced_powers
    check_to_see_if_current_suspect
    if errors.present?
      throw(:abort)
    end
  end

  private
  def check_if_convicted_felon
    if self.convicted_felon
      errors.add(:base, "This person is a convicted felon and cannot be removed from the system.")
    end
  end

  def check_if_has_enhanced_powers
    if self.enhanced_powers
      errors.add(:base, "This person is considered dangerous because of enhanced powers and cannot be removed from the system.")
    end
  end

  def check_to_see_if_current_suspect
    suspect_list = self.suspects.select{|s| s.dropped_on.nil?}
    unless suspect_list.empty?
      errors.add(:base, "This person is currently a suspect in an investigation and cannot be removed from the system.")
    end
  end
  
end
