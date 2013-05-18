class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :sections, :dependent => :destroy

  attr_accessible :name
end
