class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User (guest) if not logged in
    user ||= User.new 
    
    # set authorizations for different user roles
    if user.role? :commish
      # they get to do it all
      can :manage, :all
      
    elsif user.role? :chief
      # can manage Investigation, InvestigationNote, CrimeInvestigation, Criminal, 
      # Suspect, Assignment 
      can :manage, Investigation
      can :manage, InvestigationNote
      can :manage, CrimeInvestigation
      can :manage, Criminal
      can :manage, Suspect
      can :manage, Assignment

      # can read all
      can :read, :all
      
      # they can update their own unit
      can :update, Unit do |this_unit|
        my_unit_id = user.officer.unit.id
        my_unit_id == this_unit.id
      end
      
      # they can read their own profile
      can :read, User do |u|  
        u.id == user.id
      end

      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end
      
      # can manage their own officers
      can :manage, Officer do |this_officer|
        my_officers = user.officer.unit.officers.map(&:id)
        my_officers.include? this_officer.id
      end


    elsif user.role? :officer
      # can manage InvestigationNote, CrimeInvestigation, Criminal, Suspect
      can :manage, InvestigationNote
      can :manage, CrimeInvestigation
      can :manage, Criminal
      can :manage, Suspect
      
      # can read Investigation, Assignment, Crime
      can :read, Investigation
      can :read, Assignment
      can :read, Crime
      
      # can view list of Units
      can :index, Unit
      
      can :new, Investigation
      
      # can create an investigation
      can :create, Investigation
      
      # can only update their own open investigation
      can :update, Investigation do |this_investigation|
        my_investigations = user.officer.investigations.is_open.map(&:id)
        my_investigations.include? this_investigation.id
      end
    
      # they can read their own profile
      can :read, User do |u|  
        u.id == user.id
      end

      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end
      
      # they can read their own officer info
      can :read, Officer do |this_officer|  
        my_officer = user.officer.id
        my_officer == this_officer.id
      end

      # they can update their own officer info
      can :update, Officer do |this_officer|  
        my_officer_id = user.officer.id
        my_officer_id == this_officer.id
      end
      
      # they can show their own unit info
      can :show, Unit do |this_unit|  
        my_unit_id = user.officer.unit.id
        my_unit_id == this_unit.id
      end
      
    else
      # guests can only read crimes
      can :read, Crime
    end
  end
end