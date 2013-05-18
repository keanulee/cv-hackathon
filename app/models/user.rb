class User < ActiveRecord::Base
  has_many :resumes, :dependent => :destroy

  attr_accessible :first_name, :headline, :last_name, :linked_in_id, :location
end
