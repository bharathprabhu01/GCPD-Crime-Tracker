class CrimeInvestigation < ApplicationRecord
  include AppHelpers::Validations

  # Relationships
  belongs_to :crime
  belongs_to :investigation

  # Scopes
  scope :for_crime, -> (crime_id){ where(crime_id: crime_id) }
  scope :for_investigation, -> (investigation_id){ where(investigation_id: investigation_id) }
  
  # Validations
  validates_presence_of :crime_id, :investigation_id
  validate :crime_is_active_in_system
  validate :is_an_open_investigation

  private
  def crime_is_active_in_system
    is_active_in_system(:crime)
  end

end
