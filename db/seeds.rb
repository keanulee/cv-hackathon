# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(
  :first_name     => "Keanu",
  :headline       => "Student",
  :last_name      => "Lee",
  :linked_in_id   => "abcd1234",
  :location       => "Waterloo"
)

r = u.resumes.create(
  :name => "Master"
)

s = r.sections.create(
  :name => "Education"
)

p = s.parts.create(
  :name     => "Computer Science",
  :details  => {
    :location => "University of Waterloo"
  }
)

