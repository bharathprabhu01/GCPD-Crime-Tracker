module AppHelpers
  module Validations
    def is_active_in_system(attribute)
      # This method tests to see if the value set for the attribute is
      # (a) in the system at all, and (b) is active, if the active flag
      # is applicable.  If that is not the case, it will add an error 
      # to stop validation process.
      
      klass = Object.const_get(attribute.to_s.capitalize)
      attr_id = "#{attribute.to_s}_id"
      
      return true if attr_id.nil?

      if klass.respond_to?(:active)
        all_active = klass.active.to_a.map{|k| k.id}
      else
        # all_active = klass.to_a.map{|k| k.id}   ### not using here
      end

      unless all_active.include?(self.send(attr_id))
        self.errors.add(attr_id.to_sym, "is not active in the system")
      end
    end

    def is_an_open_investigation
      # This method tests to see an investigation is open or not and gives error if not
      return true if self.investigation.nil?
      current_open = Investigation.select{|a| a.date_closed.nil?}
      unless current_open.include?(self.investigation)
        self.errors.add(:investigation, "is not currently an open investigation")
      end
    end
  end
end