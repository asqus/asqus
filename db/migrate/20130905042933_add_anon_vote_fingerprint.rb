class AddAnonVoteFingerprint < ActiveRecord::Migration
  def up
      ActiveRecord::Base.connection.execute("
        alter table quick_poll_responses add column browser_fingerprint varchar;
        alter table quick_poll_unregistered_responses drop column uid;
        alter table quick_poll_unregistered_responses add column browser_fingerprint varchar;
        alter table quick_poll_unregistered_responses add column uid varchar;
        create index quick_poll_responses_fp_idx on quick_poll_responses(browser_fingerprint);
        create index quick_poll_unregistered_responses_fp_idx on quick_poll_responses(browser_fingerprint);        
        create index quick_poll_unregistered_responses_uid_poll_idx on quick_poll_unregistered_responses(uid,quick_poll_id);        
        create unique index quick_poll_unregistered_responses_poll_fp_uidx on quick_poll_responses(quick_poll_id,browser_fingerprint);        
        ")
  end

  def down
    ActiveRecord::Base.connection.execute("
      alter table quick_poll_responses drop column browser_fingerprint;
      alter table quick_poll_unregistered_responses drop column browser_fingerprint; 
      ")    
  end
end
