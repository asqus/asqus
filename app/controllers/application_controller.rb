class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :before_all

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

protected

  def before_all
    logger.info "************** before_all called **************"
    if user_signed_in?
      @current_user_groups = UserGroup.where( :user_id => current_user.id )
    end
    mobile_before_logic
  end

private 

  def mobile_site?
    if session[:mobile_site]
      logger.info "---- mobile_site found value " + session[:mobile_site]
      session[:mobile_site] == "1"
    else
      logger.info "---- mobile site not found"
      request.user_agent =~ /Mobile|webOS/
    end    
  end
  helper_method :mobile_site?
  
  def mobile_before_logic
    session[:mobile_site] = params[:mobile] if params[:mobile]
  end
  
  def get_poll_uid
    if (cookies[:poll_uid])
      cookies[:poll_uid]
    else
      plain = request.headers['REMOTE_ADDR'] + Time.now.to_s
      cookies[:poll_uid] = plain
    end
  end
  
end
