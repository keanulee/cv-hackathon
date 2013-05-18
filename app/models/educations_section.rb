class EducationsSection < Section
  def add_educations(educations)
    educations.each do |education|
      parts.create( :name     => education.degree,
                    :details  => education.to_hash )
    end
  end
end
