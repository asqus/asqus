class Admin::BaseController < ApplicationController

before_filter :admin_before


protected

def admin_before
  authenticate_user!
  
end
  
end