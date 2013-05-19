class ContactInfo < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :details, :email, :first_name, :last_name
end
