module ApplicationHelper

  def incumbent_officials(office_id)  
    return Official.where("id in (select official_id from official_terms o, terms t where o.term_id = t.id and o.office_id = ? and t.from_date <= ? and t.to_date >= ?)", office_id, DateTime.now, DateTime.now)
  end
  
  def offices_for_user(user_id)
    logger.info "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& called offices_for_user"
    return Office.where("id in (select group_id from user_groups where group_type = 'Office' and user_id = ?)", user_id)
  end
    

end
