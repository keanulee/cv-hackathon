class Part < ActiveRecord::Base
  belongs_to :section

  serialize :details
  
  attr_accessible :details, :name, :location, :start_date, :end_date, :notes
end
