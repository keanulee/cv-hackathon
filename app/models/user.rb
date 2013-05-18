class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :resumes, :dependent => :destroy

  def import_profile(profile)
    # TODO: import name/communication info
  end

  def import_profile_fields(profile_fields)
    resume = resumes.create( :name => "LinkedIn Imported" )

    positions_section = PositionsSection.new( :name => "Work Experience" )
    positions_section.resume = resume
    positions_section.save

    positions_section.add_positions profile_fields.positions.all

    educations_section = EducationsSection.new( :name => "Education" )
    educations_section.resume = resume
    educations_section.save

    educations_section.add_educations profile_fields.educations.all
  end
end
