class PositionsSection < Section
  def add_positions(positions)
    positions.each do |position|
      parts.create( :name     => position.title,
                    :details  => position.to_hash )
    end
  end
end