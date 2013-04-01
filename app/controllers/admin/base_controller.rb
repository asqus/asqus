class Admin::BaseController < ApplicationController

before_filter :admin_before

protected

def admin_before
  authenticate_user!
  raise AccessDenied unless current_user.site_role.name == 'Admin'
end
  
end