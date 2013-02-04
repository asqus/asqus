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
  { :id => 1, :description => 'President', :polity_type => 'Country' },
  { :id => 2, :description => 'Vice President', :polity_type => 'Country' },
  { :id => 3, :description => 'United States Senator', :polity_type => 'State' },
  { :id => 4, :description => 'United States Representative', :polity_type => 'State' },
  { :id => 5, :description => 'Governor', :polity_type => 'State' },
  { :id => 6, :description => 'Lieutenant Governor', :polity_type => 'State' },
  { :id => 7, :description => 'State Senator', :polity_type => 'State' },
  { :id => 8, :description => 'State Representative', :polity_type => 'State' },
  { :id => 9, :description => 'Mayor', :polity_type => 'Municipality' }
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
  { :id => 51, :name => 'District of Columbia', :abbreviation => 'DC' },
], :without_protection => true)

puts 'CREATING MUNICIPALITIES'
Municipality.create([
  { :id => 1, :name => "Detroit", :state_id => 22 },
  { :id => 2, :name => "Ann Arbor", :state_id => 22 },
  { :id => 3, :name => "Ypsilanti", :state_id => 22 }
], :without_protection => true)

puts 'CREATING MICHIGAN CONGRESSIONAL OFFICES'

for i in 1..15 do
  Office.create([
    { :id => i, :office_type_id => 4, :name => "U.S. Representative", :polity_id => 22, :polity_type => "State", :seat_discriminator => i }
  ], :without_protection => true)
end

puts 'CREATING MICHIGAN CONGRESSIONAL DISTRICTS'

for i in 1..15 do 
  CongressionalDistrict.create([
    { :id => i, :state_id => 22, :district_number => i }
  ], :without_protection => true)
end


puts 'CREATING OTHER OFFICES'

Office.create([
    { :id => 16, :office_type_id => 3, :name => "Senator", :polity_id => 22, :polity_type => 'State', :seat_discriminator => 1 },
    { :id => 17, :office_type_id => 3, :name => "Senator", :polity_id => 22, :polity_type => 'State', :seat_discriminator => 2 },
    { :id => 18, :office_type_id => 5, :name => "Governor", :polity_id => 22, :polity_type => 'State', :seat_discriminator => 1 },
    { :id => 19, :office_type_id => 9, :name => "Mayor", :polity_id => 1, :polity_type => 'Municipality', :seat_discriminator => 1 },
    { :id => 20, :office_type_id => 9,  :name => "Mayor", :polity_id => 2, :polity_type => 'Municipality', :seat_discriminator => 1 },
    { :id => 21, :office_type_id => 9, :name => "Mayor", :polity_id => 3, :polity_type => 'Municipality', :seat_discriminator => 1 }
], :without_protection => true)



Official.create([
  { :id => 1, :first_name => "Dan", :last_name => "Benishek", :email => "benishek@house.gov" },
  { :id => 2, :first_name => "Bill", :last_name => "Huizenga", :email => "huizenga@house.gov" },
  { :id => 3, :first_name => "Justin", :last_name => "Amash", :email => "amash@house.gov" },
  { :id => 4, :first_name => "David", :last_name => "Camp", :email => "camp@house.gov" },
  { :id => 5, :first_name => "Dale", :last_name => "Kildee", :email => "kildee@house.gov" },
  { :id => 6, :first_name => "Fred", :last_name => "Upton", :email => "upton@house.gov" },
  { :id => 7, :first_name => "Timothy", :last_name => "Walberg", :email => "walberg@house.gov" },
  { :id => 8, :first_name => "Mike", :last_name => "Rogers", :email => "rogers@house.gov" },
  { :id => 9, :first_name => "Gary", :last_name =>"Peters", :email => "peters@house.gov" },
  { :id => 10, :first_name => "Candice", :last_name => "Miller", :email => "miller@house.gov" },
  { :id => 11, :first_name => "David", :last_name => "Curson", :email => "curson@house.gov" },
  { :id => 12, :first_name => "Sander", :last_name =>"Levin", :email => "levin@house.gov" },
  { :id => 13, :first_name => "Hansen", :last_name => "Clarke", :email => "clarke@house.gov" },
  { :id => 14, :first_name => "John", :last_name => "Conyers Jr", :email => "conyers@house.gov" },
  { :id => 15, :first_name => "John", :last_name => "Dingell", :email => "dingall@house.gov" },
  { :id => 16, :first_name => "Carl", :last_name => "Levin", :email => "levin@senate.gov"},
  { :id => 17, :first_name => "Debbie", :middle_name => "Ann", :last_name => "Stabenow", :email => "stabenow@senate.gov"},
  { :id => 18, :first_name => "Richard", :last_name => "Snyner", :email => "snyder@michigan.state.us" }
], :without_protection => true)

puts 'CREATING TERMS'
Term.create([
  { :id => 1, :name => "U.S. House of Representatives 2013-15", :office_type_id => 4, :from_date => "2013-01-03", :to_date => "2015-01-03", :standard => true },
  { :id => 2, :name => "U.S. Senate 2009-2015 (Class 2)", :office_type_id => 3, :from_date => "2009-01-03", :to_date => "2015-01-03", :standard => true },
  { :id => 3, :name => "U.S. Senate 2011-2017 (Class 3)", :office_type_id => 3, :from_date => "2011-01-03", :to_date => "2017-01-03", :standard => true },
  { :id => 4, :name => "U.S. Senate 2013-2019 (Class 1)", :office_type_id => 3, :from_date => "2013-01-03", :to_date => "2019-01-03", :standard => true },
  { :id => 5, :name => "Governor 2011-2015", :office_type_id => 5, :from_date => "2011-01-01", :to_date => "2015-01-01", :standard => true }
  ])

puts 'CREATING OFFICIAL TERMS'

OfficialTerm.create([
  { :id => 1, :official_id => 1, :office_id => 1, :term_id => 1 },
  { :id => 2, :official_id => 2, :office_id => 2, :term_id => 1 },
  { :id => 3, :official_id => 3, :office_id => 3, :term_id => 1 },
  { :id => 4, :official_id => 4, :office_id => 4, :term_id => 1 },
  { :id => 5, :official_id => 5, :office_id => 5, :term_id => 1 },
  { :id => 6, :official_id => 6, :office_id => 6, :term_id => 1 },
  { :id => 7, :official_id => 7, :office_id => 7, :term_id => 1 },
  { :id => 8, :official_id => 8, :office_id => 8, :term_id => 1 },
  { :id => 9, :official_id => 9, :office_id => 9, :term_id => 1 },
  { :id => 10, :official_id => 10, :office_id => 10, :term_id => 1 },
  { :id => 11, :official_id => 11, :office_id => 11, :term_id => 1 },
  { :id => 12, :official_id => 12, :office_id => 12, :term_id => 1 },
  { :id => 13, :official_id => 13, :office_id => 13, :term_id => 1 },
  { :id => 14, :official_id => 14, :office_id => 14, :term_id => 1 },
  { :id => 15, :official_id => 15, :office_id => 15, :term_id => 1 }, 
  { :id => 16, :official_id => 16, :office_id => 16, :term_id => 2 },
  { :id => 17, :official_id => 17, :office_id => 17, :term_id => 2 },
  { :id => 18, :official_id => 18, :office_id => 18, :term_id => 5 }
], :without_protection => true)


puts 'CREATING ROLES'
Role.create([
  { :name => 'admin' }, 
  { :name => 'user' }, 
  { :name => 'VIP' }
], :without_protection => true)


puts 'SETTING UP DEFAULT USER LOGIN'
user1 = User.create! :name => 'Joe Admin', :email => 'joe@admin.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id =>15, :municipality_id => 2 

puts 'New user created: ' << user1.name

user2 = User.create! :name => 'Jane Staff', :email => 'jane@staff.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id => 15, :municipality_id => 2
puts 'New user created: ' << user2.name

user3 = User.create! :name => 'Bob User', :email => 'bob@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id =>15, :municipality_id => 2 

puts 'New user created: ' << user3.name

user4 = User.create! :name => 'Cindy User', :email => 'cindy@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id => 15, :municipality_id => 2
puts 'New user created: ' << user4.name

user5 = User.create! :name => 'Jane User', :email => 'jane@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id =>15, :municipality_id => 2 

puts 'New user created: ' << user5.name

user6 = User.create! :name => 'Frank User', :email => 'frank@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id => 15, :municipality_id => 2
puts 'New user created: ' << user6.name

user7 = User.create! :name => 'Michael User', :email => 'michael@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id =>15, :municipality_id => 2 

puts 'New user created: ' << user7.name

user8 = User.create! :name => 'Jill User', :email => 'jill@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id => 15, :municipality_id => 2
puts 'New user created: ' << user8.name

user9 = User.create! :name => 'Fred User', :email => 'fred@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id =>15, :municipality_id => 2 

puts 'New user created: ' << user9.name

user10 = User.create! :name => 'Alice User', :email => 'alice@user.com', :password => 'please', :password_confirmation => 'please', :state_id => 22, :congressional_district_id => 15, :municipality_id => 2
puts 'New user created: ' << user10.name

user1.add_role :admin
user2.add_role :VIP
 
UserGroup.create([
  { :user_id => 1, :group_type => "Office", :group_id => 16, :role => 'Staff' },
  { :user_id => 2, :group_type => "Office", :group_id => 18, :role => 'Staff' }
  
], :without_protection => true)
 
 
puts 'CREATING ISSUES'

Issue.create([
  { :id => 1, :title => "Bridge to Canada", :poller_type => 'Office', :poller_id => 15 },
  { :id => 2, :title => "Fiscal Cliff", :poller_type => 'Office', :poller_id => 15 }
], :without_protection => true )

puts 'CREATING QUICK POLL TYPES'

QuickPollType.create([
  { :id => 1, :name => "Public" },
  { :id => 2, :name => "Private" },
  { :id => 3, :name => "Anonymous" }
], :without_protection => true )

puts 'CREATING QUICK POLLS'

QuickPoll.create([
  { :id => 1, :issue_id => 1, :quick_poll_type_id => 1, :title => "Should the bridge to Canada be built?", :body => "Should $3.7 gazillion dollars be spent on a bridge to Canada?",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state_id => 2 },
  { :id => 2, :issue_id => 2, :quick_poll_type_id => 1, :title => "Taxes and the Deficit", :body => "How much to you agree or disagree with the following: It is more important to cut the budget deficit than to keep taxes from rising.",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state_id => 2 }
], :without_protection => true )

QuickPollOption.create([
  { :id => 1, :quick_poll_id => 1, :text => "Yes", :value => 1 },
  { :id => 2, :quick_poll_id => 1, :text => "No", :value => 2 },
  { :id => 3, :quick_poll_id => 2, :text => "Agree Strongly", :value => 1 },
  { :id => 4, :quick_poll_id => 2, :text => "Agree Somewhat", :value => 2 },
  { :id => 5, :quick_poll_id => 2, :text => "Neutral/Undecided", :value => 3 },
  { :id => 6, :quick_poll_id => 2, :text => "Disagree Somewhat", :value => 4 },
  { :id => 7, :quick_poll_id => 2, :text => "Disagree Strongly", :value => 5 }  
], :without_protection => true )

puts 'CREATING STANDARD POLL OPTIONS'
StandardPollOptionSet.create([
  { :id => 1, :name => "Yes or No" },
  { :id => 2, :name => "Degrees of Agreement" }
], :without_protection => true )

StandardPollOption.create([
  { :id => 1, :standard_poll_option_set_id => 1, :text => 'Yes', :value => 1 },
  { :id => 2, :standard_poll_option_set_id => 1, :text => 'No', :value => 2 },
  { :id => 3, :standard_poll_option_set_id => 2, :text => 'Agree Strongly', :value => 1 },
  { :id => 4, :standard_poll_option_set_id => 2, :text => 'Agree Somewhat', :value => 2 },
  { :id => 5, :standard_poll_option_set_id => 2, :text => 'Neutral/Undecided', :value => 3 },
  { :id => 6, :standard_poll_option_set_id => 2, :text => 'Disagree Somewhat', :value => 4 },
  { :id => 7, :standard_poll_option_set_id => 2, :text => 'Disagree Strongly', :value => 5 },
], :without_protection => true )

puts 'CREATING QUICK POLL RESPONSES'

QuickPollResponse.create([
  { :id => 1, :quick_poll_id => 1, :user_id => 1, :value => 1 },
  { :id => 2, :quick_poll_id => 1, :user_id => 2, :value => 1 },
  { :id => 3, :quick_poll_id => 1, :user_id => 3, :value => 1 },
  { :id => 4, :quick_poll_id => 1, :user_id => 4, :value => 1 },
  { :id => 5, :quick_poll_id => 1, :user_id => 5, :value => 1 },
  { :id => 6, :quick_poll_id => 1, :user_id => 6, :value => 1 },
  { :id => 7, :quick_poll_id => 1, :user_id => 7, :value => 1 },
  { :id => 8, :quick_poll_id => 1, :user_id => 8, :value => 2 }, 
  { :id => 9, :quick_poll_id => 1, :user_id => 9, :value => 2 }, 
  { :id => 10, :quick_poll_id => 1, :user_id => 10, :value => 2 }, 
  { :id => 11, :quick_poll_id => 2, :user_id => 1, :value => 1 },
  { :id => 12, :quick_poll_id => 2, :user_id => 2, :value => 2 },
  { :id => 13, :quick_poll_id => 2, :user_id => 3, :value => 3 },
  { :id => 14, :quick_poll_id => 2, :user_id => 4, :value => 4 },
  { :id => 15, :quick_poll_id => 2, :user_id => 5, :value => 5 },
  { :id => 16, :quick_poll_id => 2, :user_id => 6, :value => 2 },
  { :id => 17, :quick_poll_id => 2, :user_id => 7, :value => 3 },
  { :id => 18, :quick_poll_id => 2, :user_id => 8, :value => 2 }, 
  { :id => 19, :quick_poll_id => 2, :user_id => 9, :value => 3 }, 
  { :id => 20, :quick_poll_id => 2, :user_id => 10, :value => 5 }
])
  




  


