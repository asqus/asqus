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
OfficeType.create([
  { :id => 1, :handle => 'POTUS', :name => 'President', :polity_type => 'Nation', :title => 'President',:abbreviated_title => 'President' },
  { :id => 2, :handle => 'VPOTUS', :name => 'Vice President', :polity_type => 'Nation', :title => 'Vice President', :abbreviated_title => 'V.P.' },
  { :id => 3, :handle => 'US_SENATOR', :name => 'U.S. Senator', :polity_type => 'State', :title => 'Senator', :abbreviated_title => 'Sen.' },
  { :id => 4, :handle => 'US_REP', :name => 'U.S. Representative', :polity_type => 'State', :title => 'Representative', :abbreviated_title => 'Rep.' },
  { :id => 5, :handle => 'GOVERNOR', :name => 'Governor', :polity_type => 'State', :title => 'Governor', :abbreviated_title => 'Gov.' },
  { :id => 6, :handle => 'LT_GOVERNOR', :name => 'Lieutenant Governor', :polity_type => 'State', :title => 'Lieutenant Governor', :abbreviated_title => "Lt. Gov." },
  { :id => 7, :handle => 'STATE_SENATOR', :name => 'State Senator', :polity_type => 'State', :title => 'Senator', :abbreviated_title => 'Sen.' },
  { :id => 8, :handle => 'STATE_REP', :name => 'State Representative', :polity_type => 'State', :title => 'Representative', :abbreviated_title => 'Rep.' },
  { :id => 9, :handle => 'MAYOR', :name => 'Mayor', :polity_type => 'Municipality', :title => 'Mayor', :abbreviated_title => 'Mayor' },
  { :id => 10, :handle => 'HOUSE_DELEGATE', :name => 'U.S. House Delegate', :polity_type => 'State', :title => 'Delegate', :abbreviated_title => 'Del.' }
], :without_protection => true)

puts 'CREATING STATES'
State.create([
  { :id => 1, :name => 'Alabama', :abbreviation => 'AL'},
  { :id => 2, :name => 'Alaska', :abbreviation => 'AK' },
  { :id => 3, :name => 'Arizona', :abbreviation => 'AZ' },
  { :id => 4, :name => 'Arkansas', :abbreviation => 'AR' },
  { :id => 5, :name => 'California', :abbreviation => 'CA' },
  { :id => 6, :name => 'Colorado', :abbreviation => 'CO' },
  { :id => 7, :name => 'Connecticut', :abbreviation => 'CT' },
  { :id => 8, :name => 'Delaware', :abbreviation => 'DE' },
  { :id => 9, :name => 'Florida', :abbreviation => 'FL' },
  { :id => 10, :name => 'Georgia', :abbreviation => 'GA' },
  { :id => 11, :name => 'Hawaii', :abbreviation => 'HI' },
  { :id => 12, :name => 'Idaho', :abbreviation => 'ID' },
  { :id => 13, :name => 'Illinois', :abbreviation => 'IL' },
  { :id => 14, :name => 'Indiana', :abbreviation => 'IN' },
  { :id => 15, :name => 'Iowa', :abbreviation => 'IA' },
  { :id => 16, :name => 'Kansas', :abbreviation => 'KS' },
  { :id => 17, :name => 'Kentucky', :abbreviation => 'KY' },
  { :id => 18, :name => 'Louisiana', :abbreviation => 'LA' },
  { :id => 19, :name => 'Maine', :abbreviation => 'ME' },
  { :id => 20, :name => 'Maryland', :abbreviation => 'MD' },
  { :id => 21, :name => 'Massachusetts', :abbreviation => 'MA' },
  { :id => 22, :name => 'Michigan', :abbreviation => 'MI' },
  { :id => 23, :name => 'Minnesota', :abbreviation => 'MN' },
  { :id => 24, :name => 'Mississippi', :abbreviation => 'MS' },
  { :id => 25, :name => 'Missouri', :abbreviation => 'MO' },
  { :id => 26, :name => 'Montana', :abbreviation => 'MT' },
  { :id => 27, :name => 'Nebraska', :abbreviation => 'NE' },
  { :id => 28, :name => 'Nevada', :abbreviation => 'NV' },
  { :id => 29, :name => 'New Hampshire', :abbreviation => 'NH' },
  { :id => 30, :name => 'New Jersey', :abbreviation => 'NJ' },
  { :id => 31, :name => 'New Mexico', :abbreviation => 'NM' },
  { :id => 32, :name => 'New York', :abbreviation => 'NY' },
  { :id => 33, :name => 'North Carolina', :abbreviation => 'NC' },
  { :id => 34, :name => 'North Dakota', :abbreviation => 'ND' },
  { :id => 35, :name => 'Ohio', :abbreviation => 'OH' },
  { :id => 36, :name => 'Oklahoma', :abbreviation => 'OK' },
  { :id => 37, :name => 'Oregon', :abbreviation => 'OR' },
  { :id => 38, :name => 'Pennsylvania', :abbreviation => 'PA' },
  { :id => 39, :name => 'Rhode Island', :abbreviation => 'RI' },
  { :id => 40, :name => 'South Carolina', :abbreviation => 'SC' },
  { :id => 41, :name => 'South Dakota', :abbreviation => 'SD' },
  { :id => 42, :name => 'Tennessee', :abbreviation => 'TN' },
  { :id => 43, :name => 'Texas', :abbreviation => 'TX' },
  { :id => 44, :name => 'Utah', :abbreviation => 'UT' },
  { :id => 45, :name => 'Vermont', :abbreviation => 'VT' },
  { :id => 46, :name => 'Virginia', :abbreviation => 'VA' },
  { :id => 47, :name => 'Washington', :abbreviation => 'WA' },
  { :id => 48, :name => 'West Virginia', :abbreviation => 'WV' },
  { :id => 49, :name => 'Wisconsin', :abbreviation => 'WI' },
  { :id => 50, :name => 'Wyoming', :abbreviation => 'WY' },
  { :id => 51, :name => 'District of Columbia', :abbreviation => 'DC', :is_state => 'false' },
  { :id => 52, :name => 'American Somoa', :abbreviation => 'AS', :is_state => 'false' },
  { :id => 53, :name => 'Guam', :abbreviation => 'GU', :is_state => 'false' },
  { :id => 54, :name => 'Northern Mariana Islands', :abbreviation => 'MP', :is_state => 'false' },
  { :id => 55, :name => 'Puerto Rico', :abbreviation => 'PR', :is_state => 'false' },
  { :id => 56, :name => 'U.S. Minor Outlying Islands', :abbreviation => 'UM', :is_state => 'false' },
  { :id => 57, :name => 'Virgin Islands', :abbreviation => 'VI', :is_state => 'false' }
], :without_protection => true)

puts 'CREATING MUNICIPALITIES'
Municipality.create([
  { :name => "Detroit", :state_id => 22 },
  { :name => "Ann Arbor", :state_id => 22 },
  { :name => "Ypsilanti", :state_id => 22 }
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
      { :state_id => state.id, :district_number => district_number }, :without_protection => true
    )
    office_type_id = state.is_state ? 4 : 10
    Office.create( 
      { :office_type_id => office_type_id, :polity_id => state.id, :polity_type => 'State', :seat_discriminator => district_number },
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
    Office.create(
      { :office_type_id => 3, :polity_id => state.id, :polity_type => 'State', :seat_discriminator => class_num },
      :without_protection => true
    )
  end
  Office.create(
    { :office_type_id => 5, :polity_id => state.id, :polity_type => 'State' },
    :without_protection => true
  )
end  

puts 'CREATING OTHER OFFICES'

Office.create([
    { :office_type_id => 9, :polity_id => 1, :polity_type => 'Municipality', :seat_discriminator => 1 },
    { :office_type_id => 9, :polity_id => 2, :polity_type => 'Municipality', :seat_discriminator => 1 },
    { :office_type_id => 9, :polity_id => 3, :polity_type => 'Municipality', :seat_discriminator => 1 }
], :without_protection => true)


puts 'CREATING TERMS'
Term.create([
  { :name => "U.S. House of Representatives 2013-15", :office_type_id => 4, :from_date => "2013-01-03", :to_date => "2015-01-03", :standard => true },
  { :name => "U.S. Senate 2009-2015 (Class 2)", :office_type_id => 3, :from_date => "2009-01-03", :to_date => "2015-01-03", :standard => true },
  { :name => "U.S. Senate 2011-2017 (Class 3)", :office_type_id => 3, :from_date => "2011-01-03", :to_date => "2017-01-03", :standard => true },
  { :name => "U.S. Senate 2013-2019 (Class 1)", :office_type_id => 3, :from_date => "2013-01-03", :to_date => "2019-01-03", :standard => true },
  { :name => "Governor 2011-2015", :office_type_id => 5, :from_date => "2011-01-01", :to_date => "2015-01-01", :standard => true }
], :without_protection => true)

puts 'PROCESSING HOUSE MEMBER SUNLIGHT DATA'

imps = ImportedSunlightHouseMember.find(:all)
imps.each do |imp|
  state = State.find_by_abbreviation(imp.state)
  party = Party.find_by_abbreviation(imp.party)
  # office type is 4 for representative, 10 for territorial delegate
  office_type_id = state.is_state ? 4 : 10
  office = Office.where( :office_type_id => office_type_id, :polity_type => 'State', :polity_id => state.id, :seat_discriminator => imp.district).first
  official = Official.create({:first_name => imp.first_name, :middle_name => imp.middle_name, :last_name => imp.last_name,
                              :nickname => imp.nickname, :name_suffix => imp.name_suffix, :birth_date => imp.birth_date,
                              :gender => imp.gender, :party_id => party.id, :congress_office => imp.congress_office,
                              :phone => imp.phone, :fax => imp.fax, :website => imp.website, :webform => imp.webform,
                              :twitter_id => imp.twitter_id, :congresspedia_url => imp.congresspedia_url,
                              :youtube_url => imp.youtube_url, :facebook_id => imp.facebook_id, :fax => imp.fax,
                              :votesmart_id => imp.votesmart_id, :govtrack_id => imp.govtrack_id, :bioguide_id => imp.bioguide_id,
                              :official_rss => imp.official_rss }, :without_protection => true
                            )                             
  OfficialTerm.create( {:official_id => official.id, :term_id => 1, :office_id => office.id}, :without_protection => true )
end


puts 'PROCESSING US SENATOR SUNLIGHT DATA'

imps = ImportedSunlightSenator.find(:all)
imps.each do |imp|
  state = State.find_by_abbreviation(imp.state)
  party = Party.find_by_abbreviation(imp.party)
  office = Office.where( :office_type_id => 3, :polity_type => 'State', :polity_id => state.id, :seat_discriminator => imp.senate_class).first
  official = Official.create({:first_name => imp.first_name, :middle_name => imp.middle_name, :last_name => imp.last_name,
                              :nickname => imp.nickname, :name_suffix => imp.name_suffix, :birth_date => imp.birth_date,
                              :gender => imp.gender, :party_id => party.id, :congress_office => imp.congress_office,
                              :phone => imp.phone, :fax => imp.fax, :website => imp.website, :webform => imp.webform,
                              :twitter_id => imp.twitter_id, :congresspedia_url => imp.congresspedia_url,
                              :youtube_url => imp.youtube_url, :facebook_id => imp.facebook_id, :fax => imp.fax,
                              :votesmart_id => imp.votesmart_id, :govtrack_id => imp.govtrack_id, :bioguide_id => imp.bioguide_id,
                              :official_rss => imp.official_rss }, :without_protection => true
                            )                              
  OfficialTerm.create( {:official_id => official.id, :term_id => 1, :office_id => office.id}, :without_protection => true )
end

puts 'CREATING ROLES'
Role.create([
  { :name => 'admin' }, 
  { :name => 'user' }, 
  { :name => 'VIP' }
], :without_protection => true)


puts 'SETTING UP DEFAULT USER LOGIN'
user1 = User.create! :name => 'Joe Admin', :email => 'joe@admin.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number =>14, :municipality_id => 2 

puts 'New user created: ' << user1.name

user2 = User.create! :name => 'Jane Staff', :email => 'jane@staff.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number => 13, :municipality_id => 2
puts 'New user created: ' << user2.name

user3 = User.create! :name => 'Bob User', :email => 'bob@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number =>12, :municipality_id => 2 

puts 'New user created: ' << user3.name

user4 = User.create! :name => 'Cindy User', :email => 'cindy@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number => 11, :municipality_id => 2
puts 'New user created: ' << user4.name

user5 = User.create! :name => 'Jane User', :email => 'jane@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number => 10, :municipality_id => 2 

puts 'New user created: ' << user5.name

user6 = User.create! :name => 'Frank User', :email => 'frank@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number => 9, :municipality_id => 2
puts 'New user created: ' << user6.name

user7 = User.create! :name => 'Michael User', :email => 'michael@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number => 8, :municipality_id => 2 

puts 'New user created: ' << user7.name

user8 = User.create! :name => 'Jill User', :email => 'jill@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number => 7, :municipality_id => 2
puts 'New user created: ' << user8.name

user9 = User.create! :name => 'Fred User', :email => 'fred@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number =>6, :municipality_id => 2 

puts 'New user created: ' << user9.name

user10 = User.create! :name => 'Alice User', :email => 'alice@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_number=> 5, :municipality_id => 2
puts 'New user created: ' << user10.name

user1.add_role :admin
user2.add_role :VIP
 
michigan = State.find_by_abbreviation('MI')
admin_office = Office.where( :office_type_id => 4, :polity_id => michigan.id ).first
 
UserGroup.create([
  { :user_id => 1, :group_type => "Office", :group_id => admin_office.id, :role => 'Staff' },
  { :user_id => 2, :group_type => "Office", :group_id => admin_office.id, :role => 'Staff' }
  
], :without_protection => true)
 
 
puts 'CREATING ISSUES'

Issue.create([
  { :title => "Bridge to Canada", :poller_type => 'Office', :poller_id => admin_office.id, :comment => 'The proposal to build a bridge to Canada blah blah blah...' },
  { :title => "Fiscal Cliff", :poller_type => 'Office', :poller_id => admin_office.id, :comment => 'Scary fiscal cliff is scary blah blah blah...' }
], :without_protection => true )

puts 'CREATING QUICK POLL TYPES'

QuickPollType.create([
  { :id => 1, :name => "Public", :handle => 'PUBLIC' },
  { :id => 2, :name => "Private", :handle => 'PRIVATE' },
  { :id => 3, :name => "Anonymous", :handle => 'ANONYMOUS' }
], :without_protection => true )

puts 'CREATING QUICK POLLS'

QuickPoll.create([
  { :issue_id => 1, :quick_poll_type_id => 1, :title => "Should the bridge to Canada be built?", :body => "Should $3.7 gazillion dollars be spent on a bridge to Canada?",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state_id => 2 },
  { :issue_id => 2, :quick_poll_type_id => 1, :title => "Taxes and the Deficit", :body => "How much to you agree or disagree with the following: It is more important to cut the budget deficit than to keep taxes from rising.",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state_id => 2 }
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
  { :quick_poll_id => 1, :user_id => 10, :value => 2 }, 
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
  


  


