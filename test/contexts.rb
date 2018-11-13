# require needed files
require './test/sets/crimes'
require './test/sets/units'
require './test/sets/criminals'
require './test/sets/users'
require './test/sets/officers'
require './test/sets/investigations'
require './test/sets/crime_investigations'
require './test/sets/assignments'
require './test/sets/investigation_notes'
require './test/sets/suspects'
require './test/sets/abilities'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Crimes
  include Contexts::Units
  include Contexts::Criminals
  include Contexts::Users
  include Contexts::Officers
  include Contexts::Investigations
  include Contexts::CrimeInvestigations
  include Contexts::Assignments
  include Contexts::InvestigationNotes
  include Contexts::Suspects
  include Contexts::Abilities

  # a build_all method to quickly create a full testing context
  def build_all
    create_crimes
    create_units
    create_criminals
    create_leader_users
    create_officers
    create_investigations
    create_crime_investigations
    create_assignments
    create_investigation_notes
    create_suspects
  end

  # a destroy_all method to quickly destroy the testing context
  def destroy_all
    destroy_suspects
    destroy_investigation_notes
    destroy_assignments
    destroy_crime_investigations
    destroy_investigations
    destroy_officers
    destroy_leader_users
    destroy_criminals
    destroy_units
    destroy_crimes
  end
end