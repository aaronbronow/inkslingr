class Member < ActiveRecord::Base
  def to_param 
    id
  end
end
