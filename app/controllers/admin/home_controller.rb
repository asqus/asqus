class Admin::HomeController < Admin::BaseController

  def index
  
    uid = get_poll_uid
    @open_quick_polls = QuickPoll.where("id not in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
    @answered_quick_polls = QuickPoll.where("id in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
  
  end


end
