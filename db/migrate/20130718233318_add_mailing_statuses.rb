class AddMailingStatuses < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("
      insert into mailing_statuses(id, name) values (1, 'Initial');
      insert into mailing_statuses(id, name) values (2, 'Ready');
      insert into mailing_statuses(id, name) values (3, 'Sending');
      insert into mailing_statuses(id, name) values (4, 'Complete');
      insert into mailing_statuses(id, name) values (5, 'Error');
      )"
                            
  end

  def down
  end
end
