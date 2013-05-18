class Part < ActiveRecord::Base
  belongs_to :section

  serialize :details
  
  attr_accessible :details, :name
end
