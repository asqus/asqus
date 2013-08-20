class SiteRoleNotNull < ActiveRecord::Migration
  def up
      ActiveRecord::Base.connection.execute("
        update users set site_role_id = 1 where site_role_id is null;
        alter table users alter column site_role_id set default 1;
        alter table users alter column site_role_id set not null;      
      ")
  end

  def down
  end
end
