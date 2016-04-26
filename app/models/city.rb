class City < ActiveRecord::Base
  def deparametrize(str)
    str.split("-").join(" ").humanize
  end
end