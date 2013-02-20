puts 'POPULATING JOINED_OFFICIAL_TERMS MATERIALIZED VIEW'

ActiveRecord::Base.connection.execute(
  "insert into 
     joined_official_terms ( 
       official_term_id,
       office_id,
       official_id,
       term_id,
       office_type_id,
       party_id,
       office_polity_type,
       office_polity_id,
       office_seat_discriminator,
       term_from_date,
       term_to_date,
       office_type_name,
       office_type_handle,
       office_type_title,
       office_type_abbreviated_title,
       party_name,
       party_member_noun,
       party_abbreviation,
       official_first_name,
       official_middle_name,
       official_last_name,
       official_nickname,
       official_name_suffix,
       official_birth_date,
       official_gender,
       official_congress_office,
       official_phone,
     	 official_email,
     	 official_website,
     	 official_webform,
     	 official_twitter_id,
     	 official_congresspedia_url,
     	 official_youtube_url,
     	 official_facebook_id,
     	 official_fax,
     	 official_votesmart_id,
     	 official_govtrack_id,
     	 official_bioguide_id,
     	 official_eventful_id,
     	 official_photo_extension,
     	 official_official_rss      
       ) 
   select
       official_terms.id,
       offices.id,
       officials.id,
       terms.id,
       office_types.id,
       parties.id,
       offices.polity_type,
       offices.polity_id,
       offices.seat_discriminator,
       terms.from_date,
       terms.to_date,
       office_types.name,
       office_types.handle,
       office_types.title,
       office_types.abbreviated_title,
       parties.name,
       parties.member_noun,
       parties.abbreviation,
       officials.first_name,
     	 officials.middle_name,
     	 officials.last_name,
     	 officials.nickname,
     	 officials.name_suffix,
     	 officials.birth_date,
     	 officials.gender,
     	 officials.congress_office,
     	 officials.phone,
     	 officials.email,
     	 officials.website,
     	 officials.webform,
     	 officials.twitter_id,
     	 officials.congresspedia_url,
     	 officials.youtube_url,
     	 officials.facebook_id,
     	 officials.fax,
     	 officials.votesmart_id,
     	 officials.govtrack_id,
     	 officials.bioguide_id,
     	 officials.eventful_id,
     	 officials.photo_extension,
     	 officials.official_rss
   from 
       official_terms join officials on official_terms.official_id = officials.id
                      join terms on official_terms.term_id = terms.id
                      join offices on official_terms.office_id = offices.id
                      join parties on officials.party_id = parties.id
                      join office_types on offices.office_type_id = office_types.id"

)

