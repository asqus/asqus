class Staff::BaseController < ApplicationController
  
before_filter :staff_before

protected:

def staff_before
  
  logger.info "*********************** staff_before called ****************"
  
end


end