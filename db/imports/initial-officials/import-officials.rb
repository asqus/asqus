

ActiveRecord::Base.transaction do

  puts 'PROCESSING HOUSE MEMBER SUNLIGHT DATA'

  office_type_us_senator = OfficeType.find_by_ukey('US_SENATOR')
  office_type_us_rep = OfficeType.find_by_ukey('US_REP')
  office_type_us_house_delegate = OfficeType.find_by_ukey('US_HOUSE_DELEGATE')
  office_type_state_senator = OfficeType.find_by_ukey('STATE_SENATOR')
  office_type_state_rep = OfficeType.find_by_ukey('STATE_REP')

  imps = ImportedSunlightHouseMember.find(:all) 
  imps.each do |imp|
    state = State.find_by_abbreviation(imp.state)
    party = Party.find_by_abbreviation(imp.party)
    office_type = state.is_state ? office_type_us_rep : office_type_us_house_delegate
    office = Office.where( :office_type_id => office_type.id, :state_id => state.id, :congressional_district_no => imp.district).first
    official = Official.create({:first_name => imp.first_name, :middle_name => imp.middle_name, :last_name => imp.last_name,
                                :nickname => imp.nickname, :name_suffix => imp.name_suffix, :birth_date => imp.birth_date,
                                :gender => imp.gender, :party_id => party.id, :congress_office => imp.congress_office,
                                :phone => imp.phone, :fax => imp.fax, :website => imp.website, :webform => imp.webform,
                                :twitter_id => imp.twitter_id, :congresspedia_url => imp.congresspedia_url,
                                :youtube_url => imp.youtube_url, :facebook_id => imp.facebook_id, :fax => imp.fax,
                                :votesmart_id => imp.votesmart_id, :govtrack_id => imp.govtrack_id, :bioguide_id => imp.bioguide_id,
                                :rss => imp.official_rss, :photo_extension => 'jpg' }, :without_protection => true
                              )                             
    OfficialTerm.create( {:official_id => official.id, :term_id => 1, :office_id => office.id}, :without_protection => true )
  end


  puts 'PROCESSING US SENATOR SUNLIGHT DATA'

  imps = ImportedSunlightSenator.find(:all)
  imps.each do |imp|
    state = State.find_by_abbreviation(imp.state)
    party = Party.find_by_abbreviation(imp.party)
    office = Office.where( :office_type_id => office_type_us_senator.id, :state_id => state.id, :us_senate_class => imp.senate_class).first
    official = Official.create({:first_name => imp.first_name, :middle_name => imp.middle_name, :last_name => imp.last_name,
                                :nickname => imp.nickname, :name_suffix => imp.name_suffix, :birth_date => imp.birth_date,
                                :gender => imp.gender, :party_id => party.id, :congress_office => imp.congress_office,
                                :phone => imp.phone, :fax => imp.fax, :website => imp.website, :webform => imp.webform,
                                :twitter_id => imp.twitter_id, :congresspedia_url => imp.congresspedia_url,
                                :youtube_url => imp.youtube_url, :facebook_id => imp.facebook_id, :fax => imp.fax,
                                :votesmart_id => imp.votesmart_id, :govtrack_id => imp.govtrack_id, :bioguide_id => imp.bioguide_id,
                                :rss => imp.official_rss, :photo_extension => 'jpg' }, :without_protection => true)
    if (official)                                                    
      OfficialTerm.create( {:official_id => official.id, :term_id => 2, :office_id => office.id}, :without_protection => true )
    else
      puts 'ERROR CREATING OFFICIAL ' + imp.first_name + ' ' + imp.last_name
    end
  end



  puts 'PROCESSING OPEN STATES LEGISLATOR DATA'

  imps = ImportedOpenStatesLegislator.find(:all)
  imps.each do |imp|
    state = State.find_by_abbreviation(imp.state.upcase) 
    party = Party.find_by_name(imp.party)
    official = Official.create( { first_name: imp.first_name, last_name: imp.last_name, middle_name: imp.middle_name,
                                  name_suffix: imp.suffixes, nickname: imp.nickname, party: party,
                                  transparencydata_id: imp.transparencydata_id, external_photo_url: imp.photo_url,
                                  source_created_at: imp.source_created_at, source_updated_at: imp.source_updated_at,
                                  open_states_leg_id: imp.leg_id }, :without_protection => true )
    if (imp.active)  
      term = Term.find(7)
      office = nil
      if (imp.chamber == 'upper')
        district = StateSenateDistrict.where( state_id: state.id, district: imp.district).first
        if(!district)
          district = StateSenateDistrict.create( { state_id: state.id, district: imp.district }, :without_protection => true )
        end
        discriminator = Office.where( state_id: state.id, office_type_id: office_type_state_senator.id, state_senate_district_key: imp.district ).size.to_s    
        office = Office.create({ state_id: state.id, office_type: office_type_state_senator,  state_senate_district_key: imp.district, discriminator: discriminator }, :without_protection => true )
      else
        district = StateHouseDistrict.where( state_id: state.id, district: imp.district).first
        if(!district)
          district = StateHouseDistrict.create( { state_id: state.id, district: imp.district }, :without_protection => true )
        end      
        discriminator = Office.where( state_id: state.id, office_type_id: office_type_state_rep.id, state_house_district_key: imp.district ).size.to_s    
        office = Office.create({ state_id: state.id, office_type: office_type_state_rep, state_house_district_key: imp.district, discriminator: discriminator }, :without_protection => true )
      end
       OfficialTerm.create( {official: official, office: office, term: term }, :without_protection => true)
    end

  end 


end



