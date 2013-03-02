class Admin::BaseController < ApplicationController

before_filter :admin_before


protected

def admin_before
   logger.info "************* admin before called ***********"
end
  
end