class Suspect < ApplicationRecord
  # Relationships
  belongs_to :investigation
  belongs_to :criminal

  # Scopes
  scope :current, -> { where(dropped_on: nil) }
  scope :chronological, -> { order(:added_on) }
  scope :alphabetical, -> { joins(:criminal).order('criminals.last_name, criminals.first_name') }
  
  # Validations
  validates_presence_of :criminal_id, :investigation_id
  validates_date :added_on, on_or_before: -> { Date.current }
  validates_date :dropped_on, on_or_after: :added_on, allow_blank: true

end
