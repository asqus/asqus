class Staff::HomeController < Staff::BaseController

  def index
    @incumbent = Incumbent.find_all_by_official_id(current_user.staff_official_id)
  
  end


end
