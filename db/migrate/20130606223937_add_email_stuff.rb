class AddEmailStuff < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("
      alter table users add email_kill_switch boolean not null default 'false';
 
      create table mailing_statuses (
        id        serial primary key,
        name      varchar(32) not null  
      );
       
      create table official_mailings (
        id serial primary key,
        mailing_status_id integer not null references mailing_statuses,
        official_id integer not null references officials,
        rep_message text,
        mailing_start_time timestamp,
        mailing_end_time timestamp,
        created_at      timestamp not null default now(),
        updated_at      timestamp not null default now()    
      );
           
      create index official_mailings_status_idx on official_mailings(mailing_status_id);
      create index official_mailings_official_idx on official_mailings(official_id);
          
      create table quick_poll_mailings (
        id serial primary key,
        quick_poll_id integer not null references quick_polls,
        official_mailing_id integer not null references official_mailings      
      );      
      
      create index quick_poll_mailings_idx on quick_poll_mailings(official_mailing_id);
      create index quick_poll_mailings_poll_idx on quick_poll_mailings(quick_poll_id);
            
      create table official_mailing_recipients (
        id integer primary key,
        official_mailing_id integer not null references official_mailings,
        user_id integer not null references users      
      );
      
      create index official_mailing_recipients_mailing_idx on official_mailing_recipients(official_mailing_id);
      
      
      
      
      
    ")
      
  end

  def down
    
    ActiveRecord::Base.connection.execute("
    
      drop table official_mailing_recipients;
      drop table quick_poll_mailings;
      drop table official_mailings;
      drop table mailing_statuses;
      alter table users drop column email_kill_switch;
    
    ")
       
  end
end
