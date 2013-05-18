class Section < ActiveRecord::Base
  belongs_to :resume
  has_many :parts, :dependent => :destroy

  attr_accessible :name
end
