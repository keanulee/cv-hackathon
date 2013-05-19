class PositionsSection < Section
  def add_positions(positions)
    positions.each do |position|
      parts.create( :name       => position.title,
                    :location   => position.company.name,
                    :start_date => date_hash_to_string(position.start_date),
                    :end_date   => date_hash_to_string(position.end_date),
                    :notes      => position.summary,
                    :details    => position.to_hash )
    end
  end
end
