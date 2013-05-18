# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.first

if u
  r = u.resumes.create(
    :name => "Master"
  )

  s = r.sections.create(
    :name => "Education"
  )

  r1 = u.resumes.create(
    :name => "Dev"
  )

  r2 = u.resumes.create(
    :name => "Design"
  )

  s1 = r1.sections.create(
    :name => "Projects"
  )

  s2 = r1.sections.create(
    :name => "Work Experience"
  )

  s3 = r2.sections.create(
    :name => "Work Experience"
  )

  p = s.parts.create(
    :name => "Computer Science",
    :details => {
      :location => "University of Waterloo"
    }
  )

  p2 = s.parts.create(
    :name => "Business Administration",
    :details => {
      :location => "Wilfrid Laurier University"
    }
  )

  p1 = s1.parts.create(
    :name => "FounderFinder",
    :details => {
      :location => "Hackathon"
      }
  )

  p3 = s2.parts.create(
    :name => "Computer Science",
    :details => {
      :location => "University of Waterloo"
    }
  )
  p4 = s1.parts.create(
    :name => "Computer Science",
    :details => {
      :location => "University of Waterloo"
    }
  )
end
