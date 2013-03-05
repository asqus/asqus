class Staff::BaseController < ApplicationController
  
before_filter :staff_before

protected

def staff_before
  authenticate_user!
  
end


end