module ApplicationHelper
  def ci_id_from(crime, investigation)
    CrimeInvestigation.where(crime_id: crime.id, investigation_id: investigation.id).first.id
  end
end
