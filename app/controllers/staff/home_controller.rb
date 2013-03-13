class Staff::HomeController < Staff::BaseController

  def index
    @incumbent = Incumbent.find_all_by_official_id(current_user.staff_official_id).first
    @issues = Issue.find_all_by_poller_type_and_poller_id('Office',@incumbent.office_id)  
    issue_ids = []
    @issues.each do |i|
      issue_ids.push(i.id)
    end      
    @quick_polls = QuickPoll.find_all_by_issue_id(issue_ids)
  end


end
