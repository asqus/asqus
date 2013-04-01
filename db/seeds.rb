#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



ActiveRecord::Base.transaction do


puts 'CREATING SITE ROLES'

site_role_user = SiteRole.create( {:name => 'User'}, :without_protection => true )
site_role_admin = SiteRole.create( {:name => 'Admin'}, :without_protection => true )

puts 'SITE ROLE: ' + site_role_admin.id.to_s


puts 'CREATING POLL WORKFLOW STATES'
poll_workflow_state_start = PollWorkflowState.create( {:name => 'Start'}, :without_protection => true )
poll_workflow_state_published = PollWorkflowState.create( {:name => 'Published'}, :without_protection => true )
poll_workflow_state_closed = PollWorkflowState.create( {:name => 'Closed'}, :without_protection => true )


puts 'CREATING POLITY TYPES'

polity_type_nation = PolityType.create( { :name => 'Nation'}, :without_protection => true )
polity_type_state = PolityType.create( { :name => 'State'}, :without_protection => true )
polity_type_senate_seat = PolityType.create( { :name => 'SenateSeat'}, :without_protection => true )
polity_type_congressional_district = PolityType.create( { :name => 'CongressionalDistrict'}, :without_protection => true )
polity_type_state_senate_district = PolityType.create( { :name => 'StateSenateDistrict'}, :without_protection => true )
polity_type_state_house_district = PolityType.create( { :name => 'StateHouseDistrict'}, :without_protection => true )
polity_type_county = PolityType.create( { :name => 'County'}, :without_protection => true )
polity_type_municipality = PolityType.create( { :name => 'Municipality'}, :without_protection => true )
polity_type_ward = PolityType.create( { :name => 'Ward'}, :without_protection => true )



puts 'CREATING OFFICE TYPES'

office_type_POTUS = OfficeType.create( { :ukey => 'POTUS', :name => 'President', :polity_type => polity_type_nation, :title => 'President', :abbreviated_title => 'President'}, :without_protection => true )
office_type_VPOTUS = OfficeType.create( { :ukey => 'VPOTUS', :name => 'Vice President', :polity_type => polity_type_nation, :title => 'Vice President', :abbreviated_title => 'V.P.'}, :without_protection => true )
office_type_US_SENATOR = OfficeType.create( { :ukey => 'US_SENATOR', :name => 'U.S. Senator', :polity_type => polity_type_senate_seat, :title => 'Senator', :abbreviated_title => 'Sen.'}, :without_protection => true )
office_type_US_REP = OfficeType.create( { :ukey => 'US_REP', :name => 'U.S. Representative', :polity_type => polity_type_congressional_district, :title => 'Representative', :abbreviated_title => 'Rep.'}, :without_protection => true )
office_type_GOVERNOR = OfficeType.create( { :ukey => 'GOVERNOR', :name => 'Governor', :polity_type => polity_type_state, :title => 'Governor', :abbreviated_title => 'Gov.'}, :without_protection => true )
office_type_LT_GOVERNOR = OfficeType.create( { :ukey => 'LT_GOVERNOR', :name => 'Lieutenant Governor', :polity_type => polity_type_state, :title => 'Lieutenant Governor', :abbreviated_title => 'Lt. Gov.'}, :without_protection => true )
office_type_STATE_SENATOR = OfficeType.create( { :ukey => 'STATE_SENATOR', :name => 'State Senator', :polity_type => polity_type_state_senate_district, :title => 'Senator', :abbreviated_title => 'Sen.'}, :without_protection => true )
office_type_STATE_REP = OfficeType.create( { :ukey => 'STATE_REP', :name => 'State Representative', :polity_type => polity_type_state_house_district , :title => 'Representative', :abbreviated_title => 'Rep.'}, :without_protection => true )
office_type_MAYOR = OfficeType.create( { :ukey => 'MAYOR', :name => 'Mayor', :polity_type => polity_type_municipality, :title => 'Mayor', :abbreviated_title => 'Mayor'}, :without_protection => true )
office_type_US_HOUSE_DELEGATE = OfficeType.create( { :ukey => 'US_HOUSE_DELEGATE', :name => 'House Delegate', :polity_type => polity_type_congressional_district, :title => 'Delegate', :abbreviated_title => 'Del'}, :without_protection => true )


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
    office_type = state.is_state ? office_type_US_REP : office_type_US_HOUSE_DELEGATE
    Office.create( 
      { :office_type => office_type, :state_id => state.id, :congressional_district_no => district_number },
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
      { :office_type => office_type_US_SENATOR, :state_id => state.id, :us_senate_class => class_num },
        :without_protection => true
    )
  end
end  

puts 'CREATING TERMS'
Term.create([
  { :name => "U.S. House of Representatives 2013-15", :office_type => office_type_US_REP, :from_date => "2013-01-03", :to_date => "2015-01-03", :standard => true },
  { :name => "U.S. Senate 2009-2015 (Class 2)", :office_type => office_type_US_SENATOR, :from_date => "2009-01-03", :to_date => "2015-01-03", :standard => true },
  { :name => "U.S. Senate 2011-2017 (Class 3)", :office_type => office_type_US_SENATOR, :from_date => "2011-01-03", :to_date => "2017-01-03", :standard => true },
  { :name => "U.S. Senate 2013-2019 (Class 1)", :office_type => office_type_US_SENATOR, :from_date => "2013-01-03", :to_date => "2019-01-03", :standard => true },
  { :name => "Governor 2011-2015", :office_type => office_type_GOVERNOR, :from_date => "2011-01-01", :to_date => "2015-01-01", :standard => true },
  { :name => "State legislature 2013-2015", :office_type =>  office_type_STATE_REP, :from_date => "2013-01-01", :to_date => '2015-01-01', :standard => true },
  { :name => "State legislature 2013-2015", :office_type =>  office_type_STATE_SENATOR, :from_date => "2013-01-01", :to_date => '2015-01-01', :standard => true }
], :without_protection => true)


puts 'SETTING UP USERS'

user1 = User.create({ :first_name => 'Joe', :last_name => 'Admin', :email => 'joe@admin.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_admin }, :without_protection => true )
puts 'New user created: ' << user1.name

user2 = User.create({ :first_name => 'Jane', :last_name => 'Staff', :email => 'jane@staff.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user2.name

user3 = User.create({ :first_name => 'Bob', :last_name => 'User', :email => 'bob@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user3.name

user4 = User.create({ :first_name => 'Cindy', :last_name => 'User', :email => 'cindy@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user4.name

user5 = User.create({ :first_name => 'Jane' , :last_name => 'User', :email => 'jane@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user5.name

user6 = User.create({ :first_name => 'Frank', :last_name => 'User', :email => 'frank@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user6.name

user7 = User.create({ :first_name => 'Michael', :last_name => 'User', :email => 'michael@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user7.name

user8 = User.create({ :first_name => 'Jill', :last_name => 'User', :email => 'jill@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user8.name

user9 = User.create({ :first_name => 'Fred', :last_name => 'User', :email => 'fred@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user9.name

user10 = User.create({ :first_name => 'Alice', :last_name => 'User', :email => 'alice@user.com', :password => 'please', :password_confirmation => 'please', :rep_state_id => 26, :site_role => site_role_user }, :without_protection => true )
puts 'New user created: ' << user10.name


michigan = State.find_by_abbreviation('MI')
admin_office = Office.where( :office_type_id => office_type_US_REP.id, :state_id => michigan.id ).first
 

puts 'CREATING ISSUES'

issue1 = Issue.create( { :title => "Bridge to Canada", :poller_type => 'Office', :poller_id => admin_office.id, :comment => 'The bridge from Detroit to Canada is a significant investment that must be considere carefully.' }, :without_protection => true )
issue2 = Issue.create( { :title => "Parking Lot Skating Rink", :poller_type => 'Office', :poller_id => admin_office.id, :comment => 'The proposal involves installing and maintaining a public skating rink on top of the underground parking lot adjacent to the Library' }, :without_protection => true )
  
graph_type_pie = GraphType.create({:name => 'Pie Chart'}, :without_protection => true )
graph_type_bar = GraphType.create({:name => 'Bar'}, :without_protection => true )


puts 'CREATING QUICK POLL TYPES'


quick_poll_type_public = QuickPollType.create( { :name => 'Public'}, :without_protection => true )
quick_poll_type_private = QuickPollType.create( { :name => 'Private'}, :without_protection => true )
quick_poll_type_anonymous = QuickPollType.create( { :name => 'Anonymous'}, :without_protection => true )

puts 'CREATING QUICK POLLS'


poll1 = QuickPoll.create(
  { :issue => issue1, :quick_poll_type => quick_poll_type_public, :title => "Detroit to Canada Bridge", :body => "Do you agree with the proposed bridge from Detroit to Canada?",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state => poll_workflow_state_published , :graph_type => graph_type_pie }, :without_protection => true )


poll2 = QuickPoll.create(
  { :issue => issue2, :quick_poll_type => quick_poll_type_public, :title => "Public Skating Rink", :body => "Should Ann Arbor have a skating rink on top of the Downtown Public Library Lot?",
    :start_time => Date.parse("01 Jan 2012"), :end_time => Date.parse('01 Jan 2013'), :poll_workflow_state => poll_workflow_state_published, :graph_type => graph_type_pie }, :without_protection => true )


puts 'CREATING QUICK POLL OPTIONS'

QuickPollOption.create([
  { :quick_poll => poll1, :text => "Yes", :value => 1 },
  { :quick_poll => poll1, :text => "No", :value => 2 },
  { :quick_poll => poll2, :text => "Agree Strongly", :value => 1 },
  { :quick_poll => poll2, :text => "Agree Somewhat", :value => 2 },
  { :quick_poll => poll2, :text => "Neutral/Undecided", :value => 3 },
  { :quick_poll => poll2, :text => "Disagree Somewhat", :value => 4 },
  { :quick_poll => poll2, :text => "Disagree Strongly", :value => 5 }  
], :without_protection => true )

puts 'CREATING STANDARD POLL OPTIONS'
std_poll_option_set_yn = StandardPollOptionSet.create({ :name => "Yes or No" }, :without_protection => true)
std_poll_option_set_degrees = StandardPollOptionSet.create({ :name => "Degrees of Agreement" }, :without_protection => true)

StandardPollOption.create([
  { :standard_poll_option_set => std_poll_option_set_yn, :text => 'Yes', :value => 1 },
  { :standard_poll_option_set => std_poll_option_set_yn, :text => 'No', :value => 2 },
  { :standard_poll_option_set => std_poll_option_set_degrees, :text => 'Agree Strongly', :value => 1 },
  { :standard_poll_option_set => std_poll_option_set_degrees, :text => 'Agree Somewhat', :value => 2 },
  { :standard_poll_option_set => std_poll_option_set_degrees, :text => 'Neutral/Undecided', :value => 3 },
  { :standard_poll_option_set => std_poll_option_set_degrees, :text => 'Disagree Somewhat', :value => 4 },
  { :standard_poll_option_set => std_poll_option_set_degrees, :text => 'Disagree Strongly', :value => 5 },
], :without_protection => true )

puts 'CREATING QUICK POLL RESPONSES'

QuickPollResponse.create([
  { :quick_poll => poll1, :user => user1, :value => 1 },
  { :quick_poll => poll1, :user => user2, :value => 1 },
  { :quick_poll => poll1, :user => user3, :value => 1 },
  { :quick_poll => poll1, :user => user4, :value => 1 },
  { :quick_poll => poll1, :user => user5, :value => 1 },
  { :quick_poll => poll1, :user => user6, :value => 1 },
  { :quick_poll => poll1, :user => user7, :value => 1 },
  { :quick_poll => poll1, :user => user8, :value => 2 }, 
  { :quick_poll => poll1, :user => user9, :value => 2 }, 
  { :quick_poll => poll1, :user => user10,:value => 2 }, 
  { :quick_poll => poll2, :user => user1, :value => 1 },
  { :quick_poll => poll2, :user => user2, :value => 2 },
  { :quick_poll => poll2, :user => user3, :value => 3 },
  { :quick_poll => poll2, :user => user4, :value => 4 },
  { :quick_poll => poll2, :user => user5, :value => 5 },
  { :quick_poll => poll2, :user => user6, :value => 2 },
  { :quick_poll => poll2, :user => user7, :value => 3 },
  { :quick_poll => poll2, :user => user8, :value => 2 }, 
  { :quick_poll => poll2, :user => user9, :value => 3 }, 
  { :quick_poll => poll2, :user => user10, :value => 5 }
], :without_protection => true)

puts 'CREATING PARTIES'

Party.create( { :id => 0, :name => 'Independent', :member_noun => 'Independent', :abbreviation => 'I'}, :without_protection => true )
Party.create( { :id => 1, :name => 'Democratic', :member_noun => 'Democrat', :abbreviation => 'D'}, :without_protection => true )
Party.create( { :id => 2, :name => 'Republican', :member_noun => 'Republican',:abbreviation => 'R'}, :without_protection => true )
Party.create( { :id => 3, :name => 'Green', :member_noun => 'Green', :abbreviation => 'G'}, :without_protection => true )
Party.create( { :id => 4, :name => 'Progressive', :member_noun => 'Progressive',:abbreviation => 'P'}, :without_protection => true )
Party.create( { :id => 5, :name => 'Democratic-Farmer-Labor', :member_noun => 'Democratic-Farmer-Labor', :abbreviation => 'DFL'}, :without_protection => true )
Party.create( { :id => 6, :name => 'Partido Nuevo Progresista', :member_noun => 'Partido Nuevo Progresista', :abbreviation => 'PNP'}, :without_protection => true )
Party.create( { :id => 7, :name => 'Partido Popular Democratico', :member_noun => 'Partido Popular Democratico', :abbreviation => 'PPD'}, :without_protection => true )



end





