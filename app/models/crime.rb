class Crime < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  include AppHelpers::Deletions

  # Relationships
  has_many :crime_investigations
  has_many :investigations, through: :crime_investigations
  
  # Scopes
  scope :alphabetical, -> { order(:name) }
  scope :felonies, -> { where(felony: true) }
  scope :misdemeanors, -> { where.not(felony: true) }

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Callback - to prevent deletions
  before_destroy :cannot_destroy_object

end
