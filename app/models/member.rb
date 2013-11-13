class Member < ActiveRecord::Base
  def to_param 
    screen_Name 
  end
end
