#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'CREATING POLL WORKFLOW STATES'
PollWorkflowState.create([
  { :name => 'Start' },
  { :name => 'Published' },
  { :name => 'Closed' }
], :without_protection => true)

puts 'CREATING OFFICE TYPES'


ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('POTUS','President','Nation','President','President')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('VPOTUS','Vice President','Nation','Vice President','V.P.')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('US_SENATOR','U.S. Senator','SenateSeat','Senator','Sen.')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('US_REP','U.S. Representative','CongressionalDistrict','Representative','Rep.')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('GOVERNOR','Governor','State','Governor','Gov.')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('LT_GOVERNOR','Lieutenant Governor','State','Lieutenant Governor','Lt. Gov.')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('STATE_SENATOR','State Senator','StateSenateDistrict','Senator','Sen.')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('STATE_REP','State Representative','StateHouseDistrict','Representative','Rep.')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('MAYOR','Mayor','Municipality','Mayor','Mayor')"
)
ActiveRecord::Base.connection.execute(
  "insert into office_types( id, name, polity_type, title, abbreviated_title) values ('US_HOUSE_DELEGATE','U.S. House Delegate','CongressionalDistrict','Delegate','Del.')"
)


puts 'CREATING STATES'
State.create([
  { :id => 1, :name => 'Alabama', :abbreviation => 'AL'},
  { :id => 2, :name => 'Alaska', :abbreviation => 'AK' },
  { :id => 4, :name => 'Arizona', :abbreviation => 'AZ' },
  { :id => 5, :name => 'Arkansas', :abbreviation => 'AR' },
  { :id => 6, :name => 'California', :abbreviation => 'CA' },
  { :id => 8, :name => 'Colorado', :abbreviation => 'CO' },
  { :id => 9, :name => 'Connecticut', :abbreviation => 'CT' },
  { :id => 10, :name => 'Delaware', :abbreviation => 'DE' },
  { :id => 12, :name => 'Florida', :abbreviation => 'FL' },
  { :id => 13, :name => 'Georgia', :abbreviation => 'GA' },
  { :id => 15, :name => 'Hawaii', :abbreviation => 'HI' },
  { :id => 16, :name => 'Idaho', :abbreviation => 'ID' },
  { :id => 17, :name => 'Illinois', :abbreviation => 'IL' },
  { :id => 18, :name => 'Indiana', :abbreviation => 'IN' },
  { :id => 19, :name => 'Iowa', :abbreviation => 'IA' },
  { :id => 20, :name => 'Kansas', :abbreviation => 'KS' },
  { :id => 21, :name => 'Kentucky', :abbreviation => 'KY' },
  { :id => 22, :name => 'Louisiana', :abbreviation => 'LA' },
  { :id => 23, :name => 'Maine', :abbreviation => 'ME' },
  { :id => 24, :name => 'Maryland', :abbreviation => 'MD' },
  { :id => 25, :name => 'Massachusetts', :abbreviation => 'MA' },
  { :id => 26, :name => 'Michigan', :abbreviation => 'MI' },
  { :id => 27, :name => 'Minnesota', :abbreviation => 'MN' },
  { :id => 28, :name => 'Mississippi', :abbreviation => 'MS' },
  { :id => 29, :name => 'Missouri', :abbreviation => 'MO' },
  { :id => 30, :name => 'Montana', :abbreviation => 'MT' },
  { :id => 31, :name => 'Nebraska', :abbreviation => 'NE' },
  { :id => 32, :name => 'Nevada', :abbreviation => 'NV' },
  { :id => 33, :name => 'New Hampshire', :abbreviation => 'NH' },
  { :id => 34, :name => 'New Jersey', :abbreviation => 'NJ' },
  { :id => 35, :name => 'New Mexico', :abbreviation => 'NM' },
  { :id => 36, :name => 'New York', :abbreviation => 'NY' },
  { :id => 37, :name => 'North Carolina', :abbreviation => 'NC' },
  { :id => 38, :name => 'North Dakota', :abbreviation => 'ND' },
  { :id => 39, :name => 'Ohio', :abbreviation => 'OH' },
  { :id => 40, :name => 'Oklahoma', :abbreviation => 'OK' },
  { :id => 41, :name => 'Oregon', :abbreviation => 'OR' },
  { :id => 42, :name => 'Pennsylvania', :abbreviation => 'PA' },
  { :id => 44, :name => 'Rhode Island', :abbreviation => 'RI' },
  { :id => 45, :name => 'South Carolina', :abbreviation => 'SC' },
  { :id => 46, :name => 'South Dakota', :abbreviation => 'SD' },
  { :id => 47, :name => 'Tennessee', :abbreviation => 'TN' },
  { :id => 48, :name => 'Texas', :abbreviation => 'TX' },
  { :id => 49, :name => 'Utah', :abbreviation => 'UT' },
  { :id => 50, :name => 'Vermont', :abbreviation => 'VT' },
  { :id => 51, :name => 'Virginia', :abbreviation => 'VA' },
  { :id => 53, :name => 'Washington', :abbreviation => 'WA' },
  { :id => 54, :name => 'West Virginia', :abbreviation => 'WV' },
  { :id => 55, :name => 'Wisconsin', :abbreviation => 'WI' },
  { :id => 56, :name => 'Wyoming', :abbreviation => 'WY' },
  { :id => 11, :name => 'District of Columbia', :abbreviation => 'DC', :is_state => 'false' },
  { :id => 60, :name => 'American Somoa', :abbreviation => 'AS', :is_state => 'false' },
  { :id => 66, :name => 'Guam', :abbreviation => 'GU', :is_state => 'false' },
  { :id => 69, :name => 'Northern Mariana Islands', :abbreviation => 'MP', :is_state => 'false' },
  { :id => 72, :name => 'Puerto Rico', :abbreviation => 'PR', :is_state => 'false' },
  { :id => 74, :name => 'U.S. Minor Outlying Islands', :abbreviation => 'UM', :is_state => 'false' },
  { :id => 78, :name => 'Virgin Islands', :abbreviation => 'VI', :is_state => 'false' }
], :without_protection => true)



puts 'CREATING CONGRESSIONAL DISTRICTS AND OFFICES'

house_districts = { :AL => 7, :AK => 1, :AZ => 9, :AR => 4, :CA => 53, 
                    :CO => 7, :CT => 5, :DE => 1, :FL => 27, :GA => 14, 
                    :HI => 2, :ID => 2, :IL => 18, :IN => 9, :IA => 4, 
                    :KS => 4, :KY => 6, :LA => 6, :ME => 2, :MD => 8, 
                    :MA => 9, :MI => 14, :MN => 8, :MS => 4, :MO => 8, 
                    :MT => 1, :NE => 3, :NV => 4, :NH => 2, :NJ => 12, 
                    :NM => 3, :NY => 27, :NC => 13, :ND => 1, :OH => 16, 
                    :OK => 5, :OR => 5, :PA => 18, :RI => 2, :SC => 7, 
                    :SD => 1, :TN => 9, :TX => 36, :UT => 4, :VT => 1, 
                    :VA => 11, :WA => 10, :WV => 3, :WI => 8, :WY => 1,
                    :DC => 1, :AS => 1, :GU => 1, :MP => 1, :UM => 1, :VI => 1, :PR => 1 }

house_districts.each_pair do |st, num_districts|
  state = State.find_by_abbreviation(st)
  puts state.name
  for i in 1..num_districts do
    # if there is only one district in state/territory, convention is to number it zero
    district_number = num_districts > 1 ? i : 0
    district = CongressionalDistrict.create(
      { :state => state, :district => district_number }, :without_protection => true
    )
    office_type_id = state.is_state ? 'US_REP' : 'US_HOUSE_DELEGATE'
    Office.create( 
      { :office_type_id => office_type_id, :state_id => state.id, :congressional_district_no => district_number },
      :without_protection => true
    )    
  end
end

senate_classes = { :AL => [2,3], :AK => [2,3], :AZ => [1,3], :AR => [2,3], :CA => [1,3], 
                   :CO => [2,3], :CT => [1,3], :DE => [1,2], :FL => [1,3], :GA => [2,3], 
                   :HI => [1,3], :ID => [2,3], :IL => [2,3], :IN => [1,3], :IA => [2,3], 
                   :KS => [2,3], :KY => [2,3], :LA => [2,3], :ME => [1,2], :MD => [1,3], 
                   :MA => [1,2], :MI => [1,2], :MN => [1,2], :MS => [1,2], :MO => [1,3], 
                   :MT => [1,2], :NE => [1,2], :NV => [1,3], :NH => [2,3], :NJ => [1,2], 
                   :NM => [1,2], :NY => [1,3], :NC => [2,3], :ND => [1,3], :OH => [1,3], 
                   :OK => [2,3], :OR => [2,3], :PA => [1,3], :RI => [1,2], :SC => [2,3], 
                   :SD => [2,3], :TN => [1,2], :TX => [1,2], :UT => [1,3], :VT => [1,3], 
                   :VA => [1,2], :WA => [1,3], :WV => [1,2], :WI => [1,3], :WY => [1,2] }

puts 'CREATING US SENATE, GOVERNOR OFFICES'

senate_classes.each_pair do |st, classes|
  state = State.find_by_abbreviation(st)
  classes.each do |class_num|
    office = Office.create(
      { :office_type_id => 'US_SENATOR', :state_id => state.id, :us_senate_class => class_num },
      :without_protection => true
    )
  end
end  

puts 'CREATING TERMS'
Term.create([
  { :name => "U.S. House of Representatives 2013-15", :office_type_id => 'US_REP', :from_date => "2013-01-03", :to_date => "2015-01-03", :standard => true },
  { :name => "U.S. Senate 2009-2015 (Class 2)", :office_type_id => 'US_SENATOR', :from_date => "2009-01-03", :to_date => "2015-01-03", :standard => true },
  { :name => "U.S. Senate 2011-2017 (Class 3)", :office_type_id => 'US_SENATOR', :from_date => "2011-01-03", :to_date => "2017-01-03", :standard => true },
  { :name => "U.S. Senate 2013-2019 (Class 1)", :office_type_id => 'US_SENATOR', :from_date => "2013-01-03", :to_date => "2019-01-03", :standard => true },
  { :name => "Governor 2011-2015", :office_type_id => 'GOVERNOR', :from_date => "2011-01-01", :to_date => "2015-01-01", :standard => true },
  { :name => "State legislature 2013-2015", :office_type_id => "STATE_REP", :from_date => "2013-01-01", :to_date => '2015-01-01', :standard => true },
  { :name => "State legislature 2013-2015", :office_type_id => "STATE_SENATOR", :from_date => "2013-01-01", :to_date => '2015-01-01', :standard => true }
], :without_protection => true)


puts 'PROCESSING HOUSE MEMBER SUNLIGHT DATA'

imps = ImportedSunlightHouseMember.find(:all)
imps.each do |imp|
  state = State.find_by_abbreviation(imp.state)
  party = Party.find_by_abbreviation(imp.party)
  office_type_id = state.is_state ? 'US_REP' : 'US_HOUSE_DELEGATE'
  office = Office.where( :office_type_id => office_type_id, :state_id => state.id, :congressional_district_no => imp.district).first
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
  office = Office.where( :office_type_id => 'US_SENATOR', :state_id => state.id, :us_senate_class => imp.senate_class).first
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
      discriminator = Office.where( state_id: state.id, office_type_id: 'STATE_SENATOR', state_senate_district_key: imp.district ).size.to_s    
      office = Office.create({ state_id: state.id, office_type_id: 'STATE_SENATOR',  state_senate_district_key: imp.district, discriminator: discriminator }, :without_protection => true )
    else
      district = StateHouseDistrict.where( state_id: state.id, district: imp.district).first
      if(!district)
        district = StateHouseDistrict.create( { state_id: state.id, district: imp.district }, :without_protection => true )
      end      
      discriminator = Office.where( state_id: state.id, office_type_id: 'STATE_REP', state_house_district_key: imp.district ).size.to_s    
      office = Office.create({ state_id: state.id, office_type_id: 'STATE_REP', state_house_district_key: imp.district, discriminator: discriminator }, :without_protection => true )
    end
     OfficialTerm.create( {official: official, office: office, term: term }, :without_protection => true)
  end

end



puts 'SETTING UP USERS'

user1 = User.create({ :first_name => 'Joe', :last_name => 'Admin', :email => 'joe@admin.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no =>14, :rep_state_senate_district_key => '2', :rep_state_house_district_key => '3', :site_role => SiteRole::ADMIN}, :without_protection => true )
puts 'New user created: ' << user1.name

official = Official.find(1000)
user2 = User.create({ :first_name => 'Jane', :last_name => 'Staff', :email => 'jane@staff.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no => 13,  :rep_state_senate_district_key => '2', :rep_state_house_district_key => '3', :staff_official => official }, :without_protection => true )
puts 'New user created: ' << user2.name

user3 = User.create({ :first_name => 'Bob', :last_name => 'User', :email => 'bob@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no =>12,  :rep_state_senate_district_key => '2', :rep_state_house_district_key => '3' }, :without_protection => true )
puts 'New user created: ' << user3.name

user4 = User.create({ :first_name => 'Cindy', :last_name => 'User', :email => 'cindy@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no => 11,  :rep_state_senate_district_key => '2', :rep_state_house_district_key => '3' }, :without_protection => true )
puts 'New user created: ' << user4.name

user5 = User.create({ :first_name => 'Jane' , :last_name => 'User', :email => 'jane@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no => 10 }, :without_protection => true )
puts 'New user created: ' << user5.name

user6 = User.create({ :first_name => 'Frank', :last_name => 'User', :email => 'frank@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no => 9 }, :without_protection => true )
puts 'New user created: ' << user6.name

user7 = User.create({ :first_name => 'Michael', :last_name => 'User', :email => 'michael@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no => 8 }, :without_protection => true )
puts 'New user created: ' << user7.name

user8 = User.create({ :first_name => 'Jill', :last_name => 'User', :email => 'jill@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no => 7 }, :without_protection => true )
puts 'New user created: ' << user8.name

user9 = User.create({ :first_name => 'Fred', :last_name => 'User', :email => 'fred@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no =>6 }, :without_protection => true )
puts 'New user created: ' << user9.name

user10 = User.create({ :first_name => 'Alice', :last_name => 'User', :email => 'alice@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :rep_congressional_district_no => 5 }, :without_protection => true )
puts 'New user created: ' << user10.name


michigan = State.find_by_abbreviation('MI')
admin_office = Office.where( :office_type_id => 'US_REP', :state_id => michigan.id ).first
 


puts 'CREATING ISSUES'

Issue.create([
  { :title => "Bridge to Canada", :poller_type => 'Office', :poller_id => admin_office.id, :comment => 'The proposal to build a bridge to Canada blah blah blah...' },
  { :title => "Fiscal Cliff", :poller_type => 'Office', :poller_id => admin_office.id, :comment => 'Scary fiscal cliff is scary blah blah blah...' }
], :without_protection => true )

puts 'CREATING QUICK POLL TYPES'

ActiveRecord::Base.connection.execute(
  "insert into quick_poll_types( id, name) values ('PUBLIC','Public')"
)  
ActiveRecord::Base.connection.execute(
  "insert into quick_poll_types( id, name) values ('PRIVATE','Private')"
)  
ActiveRecord::Base.connection.execute(
  "insert into quick_poll_types( id, name) values ('ANONYMOUS','Anonymous')"
)  


puts 'CREATING QUICK POLLS'

QuickPoll.create([
  { :issue_id => 1, :quick_poll_type_id => 'PUBLIC', :title => "Should the bridge to Canada be built?", :body => "Should $3.7 gazillion dollars be spent on a bridge to Canada?",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state_id => 2, :graph_type_id => 'PIE_CHART' },
  { :issue_id => 2, :quick_poll_type_id => 'PUBLIC', :title => "Taxes and the Deficit", :body => "How much do you agree or disagree with the following: It is more important to cut the budget deficit than to keep taxes from rising.",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state_id => 2, :graph_type_id => 'BAR_CHART' }
], :without_protection => true )

QuickPollOption.create([
  { :quick_poll_id => 1, :text => "Yes", :value => 1 },
  { :quick_poll_id => 1, :text => "No", :value => 2 },
  { :quick_poll_id => 2, :text => "Agree Strongly", :value => 1 },
  { :quick_poll_id => 2, :text => "Agree Somewhat", :value => 2 },
  { :quick_poll_id => 2, :text => "Neutral/Undecided", :value => 3 },
  { :quick_poll_id => 2, :text => "Disagree Somewhat", :value => 4 },
  { :quick_poll_id => 2, :text => "Disagree Strongly", :value => 5 }  
], :without_protection => true )

puts 'CREATING STANDARD POLL OPTIONS'
StandardPollOptionSet.create([
  { :name => "Yes or No" },
  { :name => "Degrees of Agreement" }
], :without_protection => true )

StandardPollOption.create([
  { :standard_poll_option_set_id => 1, :text => 'Yes', :value => 1 },
  { :standard_poll_option_set_id => 1, :text => 'No', :value => 2 },
  { :standard_poll_option_set_id => 2, :text => 'Agree Strongly', :value => 1 },
  { :standard_poll_option_set_id => 2, :text => 'Agree Somewhat', :value => 2 },
  { :standard_poll_option_set_id => 2, :text => 'Neutral/Undecided', :value => 3 },
  { :standard_poll_option_set_id => 2, :text => 'Disagree Somewhat', :value => 4 },
  { :standard_poll_option_set_id => 2, :text => 'Disagree Strongly', :value => 5 },
], :without_protection => true )

puts 'CREATING QUICK POLL RESPONSES'

QuickPollResponse.create([
  { :quick_poll_id => 1, :user_id => 1, :value => 1 },
  { :quick_poll_id => 1, :user_id => 2, :value => 1 },
  { :quick_poll_id => 1, :user_id => 3, :value => 1 },
  { :quick_poll_id => 1, :user_id => 4, :value => 1 },
  { :quick_poll_id => 1, :user_id => 5, :value => 1 },
  { :quick_poll_id => 1, :user_id => 6, :value => 1 },
  { :quick_poll_id => 1, :user_id => 7, :value => 1 },
  { :quick_poll_id => 1, :user_id => 8, :value => 2 }, 
  { :quick_poll_id => 1, :user_id => 9, :value => 2 }, 
  { :quick_poll_id => 1, :user_id => 10,:value => 2 }, 
  { :quick_poll_id => 2, :user_id => 1, :value => 1 },
  { :quick_poll_id => 2, :user_id => 2, :value => 2 },
  { :quick_poll_id => 2, :user_id => 3, :value => 3 },
  { :quick_poll_id => 2, :user_id => 4, :value => 4 },
  { :quick_poll_id => 2, :user_id => 5, :value => 5 },
  { :quick_poll_id => 2, :user_id => 6, :value => 2 },
  { :quick_poll_id => 2, :user_id => 7, :value => 3 },
  { :quick_poll_id => 2, :user_id => 8, :value => 2 }, 
  { :quick_poll_id => 2, :user_id => 9, :value => 3 }, 
  { :quick_poll_id => 2, :user_id => 10, :value => 5 }
])


puts 'CREATING MATERIALIZED VIEWS'


ActiveRecord::Base.connection.execute(
"create table joined_official_terms as
  select 
    *,
    false as dirty
  from
    joined_official_terms_view"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_uidx on joined_official_terms(official_term_id)"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_office_idx on joined_official_terms(office_id)"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_official_idx on joined_official_terms(official_id)"
)

ActiveRecord::Base.connection.execute( 
"create index joined_official_terms_office_type_idx on joined_official_terms(office_type_id)"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_term_idx on joined_official_terms(term_id)"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_municipality_idx on joined_official_terms(state_id, municipality_ansi_code)"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_county_idx on joined_official_terms(state_id, county_ansi_code)"
)

ActiveRecord::Base.connection.execute(
"create view incumbents as select * from joined_official_terms where from_date < now() and to_date > now()"
)


ActiveRecord::Base.connection.execute(
"create or replace function joined_official_terms_refresh_row( id integer ) 
returns void 
security definer 
language 'plpgsql' as $$ 
begin 
  delete from joined_official_terms jot where jot.official_term_id = id; 
  insert into joined_official_terms select *, false from joined_official_terms_view jot where jot.official_term_id = id; 
  end 
$$")

ActiveRecord::Base.connection.execute("
create or replace function jot_official_terms_update_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  if old.id = new.id then
    perform joined_official_terms_refresh_row(new.official_term_id);
  else
    perform joined_official_terms_refresh_row(old.official_term_id);
    perform joined_official_terms_refresh_row(new.official_term_id);
  end if;
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_official_terms_update_trigger 
  after update on official_terms
    for each row execute procedure jot_official_terms_update_trigger();
")

ActiveRecord::Base.connection.execute("
create or replace function jot_official_terms_insert_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(new.official_term_id);
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_official_terms_insert_trigger 
  after insert on official_terms
    for each row execute procedure jot_official_terms_insert_trigger();
")

ActiveRecord::Base.connection.execute("
create or replace function jot_official_terms_delete_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(old.official_term_id);
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_official_terms_delete_trigger 
  after delete on official_terms
    for each row execute procedure jot_official_terms_delete_trigger();
")

ActiveRecord::Base.connection.execute("
create or replace function jot_officials_update_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(jot.official_term_id)
    from joined_official_terms jot
    where jot.official_id = new.id;
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_officials_update_trigger 
  after update on officials
    for each row execute procedure jot_officials_update_trigger();
")


ActiveRecord::Base.connection.execute("
create or replace function jot_offices_update_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(jot.official_term_id)
    from joined_official_terms jot
    where jot.office_id = new.id;
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_offices_update_trigger 
  after update on offices
    for each row execute procedure jot_offices_update_trigger();
")

ActiveRecord::Base.connection.execute("
create or replace function jot_terms_update_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(jot.official_term_id)
    from joined_official_terms jot
    where jot.term_id= new.id;
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_terms_update_trigger 
  after update on terms
    for each row execute procedure jot_terms_update_trigger();
")


ActiveRecord::Base.connection.execute("
create or replace function jot_office_types_update_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(jot.official_term_id)
    from joined_official_terms jot
    where jot.office_type_id = new.id;
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_office_types_update_trigger 
  after update on office_types
    for each row execute procedure jot_office_types_update_trigger();
")


ActiveRecord::Base.connection.execute("
create or replace function jot_municipalities_update_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(jot.official_term_id)
    from joined_official_terms jot
    where jot.state_id = new.state_id and jot.municipality_ansi_code = new.ansi_code; 
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_municipalities_update_trigger 
  after update on municipalities
    for each row execute procedure jot_municipalities_update_trigger();
")


ActiveRecord::Base.connection.execute("
create or replace function jot_counties_update_trigger()
returns trigger 
security definer language 'plpgsql' as $$
begin
  perform joined_official_terms_refresh_row(jot.official_term_id)
    from joined_official_terms jot
    where jot.state_id = new.state_id and jot.county_ansi_code = new.ansi_code; 
  return null;
end
$$")

ActiveRecord::Base.connection.execute("
create trigger jot_counties_update_trigger 
  after update on counties
    for each row execute procedure jot_counties_update_trigger();
")




