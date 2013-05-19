class Section < ActiveRecord::Base
  belongs_to :resume
  has_many :parts, :dependent => :destroy

  attr_accessible :name

  def date_hash_to_string(date_hash)
    if date_hash["year"]
      if date_hash["month"]
        if date_hash["day"]
          "#{Date::MONTHNAMES[date_hash['month']]} #{date_hash['day']}, #{date_hash['year']}"
        else
          "#{Date::MONTHNAMES[date_hash['month']]}, #{date_hash['year']}"
        end
      else
        date_hash["year"].to_s
      end
    else
      ""
    end
  end

end
