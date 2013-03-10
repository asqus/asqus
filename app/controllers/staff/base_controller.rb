class Staff::BaseController < ApplicationController
  
before_filter :staff_before

protected

def staff_before
  
  authenticate_user!
    raise AccessDenied unless current_user.staff_official_id
  end
  
end


end