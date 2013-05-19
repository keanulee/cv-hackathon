class EducationsSection < Section
  def add_educations(educations)
    educations.each do |education|
      parts.create( :name       => education.degree,
                    :location   => education.school_name,
                    :start_date => date_hash_to_string(education.start_date),
                    :end_date   => date_hash_to_string(education.end_date),
                    :notes      => education.field_of_study,
                    :details    => education.to_hash )
    end
  end
end
