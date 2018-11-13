class Unit < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods

  # Relationships
  has_many :officers
  has_many :assignments, through: :officers

  # Scopes
  scope :alphabetical, -> { order('name') }
  
  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Other methods
  def number_of_active_officers
    self.officers.active.count
  end

  def number_of_unique_open_investigations
    self.officers.map{|o| o.investigations.is_open}.flatten.uniq.count
  end

  # Callback - to handle destroying units
  before_destroy do 
    check_if_any_officers_in_unit
    if errors.present?
      throw(:abort)
    end
  end

  private
  def check_if_any_officers_in_unit
    unless self.officers.empty?
      errors.add(:base, "Unit cannot be deleted because officers are listed as unit members.")
    end
  end

end
