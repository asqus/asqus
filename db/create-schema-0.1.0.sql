begin;

create table sessions
(
	id			serial primary key,
	session_id  text,
	data		text

);


create table polity_types (
	type varchar(32) primary key
);

insert into polity_types(type) values ('Nation');
insert into polity_types(type) values ('State');
insert into polity_types(type) values ('SenateSeat');
insert into polity_types(type) values ('CongressionalDistrict');
insert into polity_types(type) values ('StateSenateDistrict');
insert into polity_types(type) values ('StateHouseDistrict');
insert into polity_types(type) values ('County');
insert into polity_types(type) values ('Municipality');
insert into polity_types(type) values ('Ward');

create table taggable_types (
	type varchar(32) primary key
);

insert into taggable_types(type) values ('Issue');		

create table nations (
	id	integer primary key,
	name text not null
);

create table states (
	id	integer primary key,
	name text not null,
	abbreviation char(2) not null,
	is_state boolean not null default 'true'
);

create unique index states_name_uidx on states(name);
create unique index states_abbreviation_uidx on states(abbreviation);
	
create table congressional_districts (
	state_id		integer not null references states,
	district    	integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now(),
	primary key		(state_id, district)
);

create unique index congressional_districts_uidx on congressional_districts( state_id, district);


create table counties (
	state_id		integer not null references states,
	ansi_code		integer not null,
	name			varchar(32) not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now(),
	primary key		(state_id, ansi_code)
);

create unique index counties_uidx on counties(state_id, name);
	
create table municipalities (
	state_id		integer not null references states,
	ansi_code		integer not null,	
	name			varchar(32) not null,
	created_at		timestamp not null default now(),
	updated_at 		timestamp not null default now(),
	primary key		(state_id, ansi_code)
);

create unique index municipalities_ansi_uidx on municipalities(ansi_code);

create table wards (
    state_id				integer not null references states,
    municipality_ansi_code	integer not null,
	ward					varchar(32) not null,
	created_at				timestamp not null default now(),
	updated_at				timestamp not null default now(),
	primary key				(state_id, municipality_ansi_code, ward),
	foreign key				(state_id,municipality_ansi_code) references municipalities(state_id,ansi_code)
);
	
create table state_house_districts (
	state_id		integer references states,
	district		varchar(64) not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now(),
	primary key		(state_id,district)
);
	
	
create table state_senate_districts (
	state_id		integer references states,
	district		varchar(64) not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now(),
	primary key		(state_id,district)
);
		
create table office_types (
	id				  varchar(20) primary key,
	name		      varchar(32) not null,
	title			  varchar(20) not null,
	abbreviated_title varchar(20) not null,
	polity_type		text not null references polity_types,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index office_types_polity_type_uidx on office_types(id, polity_type);
	
		
create table offices (
	id							serial primary key,
	office_type_id				varchar(20) not null references office_types,
	state_id					integer references states,
	us_senate_class				integer,
	congressional_district_no   integer,
	county_ansi_code			integer,
	municipality_ansi_code		integer,
	state_senate_district_key  	varchar(64),
	state_house_district_key   	varchar(64),
	ward						varchar(32),
	discriminator   			varchar(32) not null default '0',
	created_at					timestamp not null default now(),
	updated_at					timestamp not null default now(),
    foreign key					(state_id, congressional_district_no) references congressional_districts(state_id,district),
    foreign key					(state_id, county_ansi_code) references counties(state_id,ansi_code),
    foreign key					(state_id, municipality_ansi_code) references municipalities(state_id,ansi_code),
    foreign key				    (state_id, state_senate_district_key) references state_senate_districts(state_id,district),
    foreign key					(state_id, state_house_district_key) references state_house_districts(state_id,district),
    foreign key					(state_id, municipality_ansi_code, ward) references wards(state_id,municipality_ansi_code,ward),
	check						(us_senate_class in (null, 1, 2, 3))
);

create unique index offices_us_senate_uidx on offices(state_id, us_senate_class);
create unique index offices_congress_uidx on offices(state_id, congressional_district_no);
create unique index offices_state_house_uidx on offices(state_id, state_house_district_key, discriminator);
create unique index offices_state_senate_uidx on offices(state_id, state_senate_district_key, discriminator);


	
create table parties (
	id					integer primary key,
	name				varchar(32) not null,
	member_noun			varchar(32) not null,
	abbreviation		varchar(1) not null
);

insert into parties(id, name, member_noun, abbreviation ) values (0, 'Independent', 'Independent', 'I');
insert into parties(id, name, member_noun, abbreviation ) values (1, 'Democratic', 'Democrat', 'D');
insert into parties(id, name, member_noun, abbreviation ) values (2, 'Republican', 'Republican', 'R');
	
CREATE SEQUENCE officials_id_seq
	START WITH 1000
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;	
	
	
create table officials (
	id					integer primary key default nextval('officials_id_seq'),
	first_name			varchar(20) not null,
	middle_name			varchar(20),
	last_name			varchar(20) not null,
	nickname			varchar(20),
	name_suffix			varchar(20),
	birth_date			date,
	gender				char(1),
	party_id			integer references parties,
	congress_office		text,
	phone				varchar(20),
	email				varchar(256),
	website				varchar(256),
	webform				varchar(256),
	twitter_id			varchar(64),
	congresspedia_url	varchar(256),
	youtube_url			varchar(256),
	facebook_id			varchar(64),
	fax					varchar(20),
	votesmart_id		integer,
	govtrack_id			integer,
	bioguide_id			varchar(32),
	eventful_id			varchar(64),
	photo_extension		varchar(20),
	rss					varchar(256),
	open_states_leg_id	varchar(20),
	external_photo_url	varchar(255),
	transparencydata_id varchar(32),
	source_created_at	timestamp,
	source_updated_at	timestamp,
	created_at			timestamp not null default now(),
	updated_at			timestamp not null default now()
);

create index officials_name_idx on officials(last_name, first_name, middle_name );
create unique index officials_bioguide_uidx on officials(bioguide_id);
create unique index officials_votesmart_uidx on officials(votesmart_id);
create unique index officials_facebook_uidx on officials(facebook_id);
create unique index officials_open_states_leg_uidx on officials(open_states_leg_id);
	
			
create table terms (
	id				serial primary key,
	name			varchar (40),
	from_date		date not null,
	to_date			date not null,
	standard		boolean not null,
	office_type_id	varchar(20) references office_types,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now(),
	check			(to_date >= from_date)
);

create index terms_office_type_idx on terms(office_type_id);
create index terms_from_date_idx on terms(from_date);
create index terms_to_date_idx on terms(to_date);


create table official_terms (
	id				serial primary key,
	official_id		integer not null references officials,
	office_id		integer not null references offices,
	term_id			integer not null references terms,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create index official_terms_official_idx on official_terms(official_id);
create index official_terms_office_idx on official_terms(office_id);
create index official_terms_term_idx on official_terms(term_id);

create table site_roles (
	id	varchar(20) primary key
);

insert into site_roles(id) values ('USER');
insert into site_roles(id) values ('ADMIN');

create type sex as enum ('Male','Female');
	
create table users (
	id						serial primary key,
	email					varchar(255) not null,
	encrypted_password		text,
	reset_password_token	text,
	reset_password_sent_at	timestamp,
	remember_created_at		timestamp,
	sign_in_count			integer not null default 0,
	current_sign_in_at		timestamp,
	current_sign_in_ip		varchar(40),
	last_sign_in_at			timestamp,
	last_sign_in_ip			varchar(40),
	first_name				varchar(20) not null,
	last_name				varchar(20) not null,
	address1				varchar(128),
	address2				varchar(128),
	city					varchar(32),
	state					varchar(2),
	zip						varchar(10),
	state_id				integer references states,
	municipality_ansi_code	integer,
	ward_key				varchar(32),
	county_ansi_code	    integer,
	congressional_district_no	integer,
	state_senate_district_key	varchar(64), 
	state_house_district_key	varchar(64),
	latitude				numeric(10,7),
	longitude				numeric(10,7),
	facebook_current_location	text,
	birth_date				date,
	sex						sex,
    site_role_id			varchar(20) not null default 'USER' references site_roles,
    staff_official_id		integer references officials,
	created_at				timestamp not null default now(),
	updated_at				timestamp not null default now(),
	foreign key 	        (state_id, congressional_district_no) references congressional_districts(state_id, district),
	foreign key				(state_id, state_senate_district_key) references state_senate_districts(state_id, district),
	foreign key	            (state_id, state_house_district_key) references state_house_districts(state_id, district),
    foreign key				(state_id, county_ansi_code) references counties(state_id, ansi_code),	
	foreign key				(state_id, municipality_ansi_code) references municipalities(state_id, ansi_code),
	foreign key				(state_id, municipality_ansi_code,ward_key) references wards(state_id,municipality_ansi_code,ward)	
);

create unique index users_email_uidx on users(email);
create unique index users_reset_password_token_uidx on users(reset_password_token);
create index users_staff_official_idx on users(staff_official_id);
create index users_site_role_idx on users(site_role_id);
	

create table roles (
	id				serial primary key,
	name			varchar(20),
	resource_id 	integer,
	resource_type	text,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create index roles_resource_id_resource_type_name_idx on roles(resource_id, resource_type, name);
create index roles_name_idx on roles(name);
	
create table users_roles (
	id				serial primary key,
	user_id			integer not null references users,
	role_id			integer not null references roles,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index users_roles_uidx on users_roles(user_id,role_id);
		
create table authentications (
	id			serial primary key,
	user_id		integer not null references users,
	provider 	varchar(64) not null,
	uid 		varchar(64) not null,
	token		text not null,
	created_at	timestamp not null default now(),
	updated_at	timestamp not null default now()
);

create index authentications_token_idx on authentications(token);
create index authentications_uid_idx on authentications(uid);
create index authentications_user_id_idx on authentications(user_id);


create table issues (
	id				serial primary key,
	title			varchar(64) not null,
	comment			text,
	poller_type		text not null,
	poller_id		integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index issues_uidx on issues(poller_type, poller_id, title);



create table quick_poll_types (
	id				varchar(32) primary key,
	name			varchar(32) not null
);
		
create table poll_workflow_states (
	id				serial primary key,
	name			varchar(32) not null
);

create table graph_types (
	id				varchar(32) primary key,
	name			varchar(32) not null	
);

insert into graph_types(id, name) values ('PIE_CHART', 'Pie Chart');
insert into graph_types(id, name) values ('BAR_CHART', 'Bar Chart');
	

create table quick_polls (
	id				serial primary key,
	title			varchar(64) not null,
	body			text not null,
	quick_poll_type_id varchar(32) not null references quick_poll_types,
	poll_workflow_state_id	integer not null references poll_workflow_states,
	issue_id		integer not null references issues,
	graph_type_id	varchar(32) not null references graph_types,
	start_time		timestamp not null,
	end_time		timestamp not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now(),
	check			(end_time > start_time)
);

create index quick_polls_issue_idx on quick_polls(issue_id);
create index quick_polls_start_time_idx on quick_polls(start_time);
create index quick_polls_end_time_idx on quick_polls(end_time);

create table quick_poll_options (
	id				serial primary key,
	text			varchar(32) not null,
	quick_poll_id	integer not null references quick_polls,
	value			smallint not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index quick_poll_options_uidx on quick_poll_options(quick_poll_id, value);


create table quick_poll_responses (
	quick_poll_id	integer not null references quick_polls,
	user_id			integer not null references users,
	value			smallint not null,
	primary key 	(quick_poll_id,user_id),
	foreign key		(quick_poll_id,value) references quick_poll_options(quick_poll_id,value)
);

create index quick_poll_responses_user_idx on quick_poll_responses(user_id);


create table quick_poll_unregistered_responses (
	quick_poll_id	integer not null references quick_polls,
	value			smallint not null,
	uid				text,
	primary key		(quick_poll_id,uid),
	foreign key		(quick_poll_id, value) references quick_poll_options(quick_poll_id,value)	
);


create table standard_poll_option_sets (
	id			serial primary key,
	name		varchar(32) not null,
	created_at	timestamp not null default now(),
	updated_at	timestamp not null default now()
);

create unique index standard_poll_option_sets_name_uidx on standard_poll_option_sets(name);
	
create table standard_poll_options (
	id			serial primary key,
	standard_poll_option_set_id	integer not null references standard_poll_option_sets on delete cascade,
	text		varchar(32) not null,
	value		integer not null,
	created_at	timestamp not null default now(),
	updated_at	timestamp not null default now()
);

create unique index standard_poll_options_text_uidx on standard_poll_options(standard_poll_option_set_id, text);
create unique index standard_poll_options_value_uidx on standard_poll_options(standard_poll_option_set_id, value);


create table tags (
	id				serial primary key,
	tag				varchar(32) not null,
	context			varchar(32) not null default 'main',
	taggable_type	varchar(32) not null references taggable_types,
	taggable_id		integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index tags_uidx on tags(tag,context,taggable_type,taggable_id);
create index tags_taggable_idx on tags( taggable_type, taggable_id );
	


create view joined_official_terms_view as
	   select
	       	official_terms.id as official_term_id,
	       	offices.id as office_id,
	       	officials.id as official_id,
	       	terms.id as term_id,
	       	office_types.id as office_type_id,
	       	parties.id as party_id,
			offices.discriminator as office_discriminator,
	       	terms.from_date as from_date,
	       	terms.to_date as to_date,
	       	office_types.name as office_type_name,
	       	office_types.title as office_type_title,
	       	office_types.abbreviated_title as office_type_abbreviated_title,
	       	parties.name as party_name,
	       	parties.member_noun as party_member_noun,
	       	parties.abbreviation as party_abbreviation,
	       	officials.first_name as official_first_name,
			officials.middle_name as official_middle_name,
	     	officials.last_name as official_last_name,
	     	officials.nickname as official_nickname,
	     	officials.name_suffix as official_name_suffix,
	     	officials.birth_date as official_birth_date,
	     	officials.gender as official_gender,
	     	officials.congress_office as official_congress_office,
	     	officials.phone as official_phone,
	     	officials.website as official_website,
	     	officials.webform as official_webform,
	     	officials.twitter_id as official_twitter_id,
	     	officials.congresspedia_url as official_congresspedia_url,
	     	officials.youtube_url as official_youtube_url,
	     	officials.facebook_id as official_facebook_id,
	     	officials.fax as official_fax,
	     	officials.votesmart_id as official_votesmart_id,
	     	officials.govtrack_id as official_govtrack_id,
	     	officials.bioguide_id as official_bioguide_id,
	     	officials.eventful_id as official_eventful_id,
	     	officials.photo_extension as official_photo_extension,
	     	officials.rss as official_rss,
		    officials.open_states_leg_id as official_open_states_leg_id,
		    officials.external_photo_url as official_external_photo_url,
		    officials.transparencydata_id as official_transparencydata_id,
	        states.id as state_id,
	        states.name as state_name,
	        states.abbreviation as state_abbreviation,
	        offices.us_senate_class as us_senate_class,
	        offices.congressional_district_no as congressional_district,
			offices.state_house_district_key as state_house_district,
	    	offices.state_senate_district_key as state_senate_district,
	        counties.name as county_name,
	        counties.ansi_code as county_ansi_code,
	        municipalities.name as municipality_name,
	        municipalities.ansi_code as municipality_ansi_code,
			offices.ward as ward
	   from 
	       official_terms join officials on official_terms.official_id = officials.id
	                      join terms on official_terms.term_id = terms.id
	                      join offices on official_terms.office_id = offices.id
	                      join parties on officials.party_id = parties.id
	                      join office_types on offices.office_type_id = office_types.id
			      		  join states on offices.state_id = states.id
					      left outer join municipalities on offices.state_id = municipalities.state_id and offices.municipality_ansi_code = municipalities.ansi_code
						  left outer join counties on offices.state_id = counties.state_id and offices.county_ansi_code = counties.ansi_code;
	

create table questions (
	id			serial primary key,
	official_id	integer not null references officials,
	user_id		integer not null references users,
	title		text not null,
	body		text not null,
	answer		text,
	up_cache	integer not null default 0,
	down_cache	integer not null default 0,
	created_at	timestamp not null default now(),
	updated_at	timestamp not null default now()
);

create table question_votes (
	id			serial primary key,
	question_id	integer not null references questions,
	user_id		integer not null references users,
	direction	smallint not null,
	created_at	timestamp not null default now(),
	updated_at	timestamp not null default now(),
	check		(direction in (-1, 1))
);

create unique index question_votes_uidx on question_votes(question_id,user_id);

create table sunlight_congress_import (
	title			text,
	firstname		text,
	middlename		text,
	lastname		text,
	name_suffix		text,
	nickname		text,
	party			text,
	state			text,
	district		text,
	in_office		integer,
	gender			text,
	phone			text,
	fax				text,
	website			text,
	webform			text,
	congress_office text,
	bioguide_id		text,
	votesmart_id	integer,
	fec_id			text,
	govtrack_id		integer,
	crp_id			text,
	twitter_id		text,
	congresspedia_url	text,
	youtube_url		text,
	facebook_id		text,
	official_rss	text,
	senate_class	text,
	birthdate		date
	
);

create table census_national_place_import (
  state_abbreviation	text,
  state_id				integer,
  place_id			integer,
  place_name			text,
  place_type			text,
  status				char(1),
  county				text
);
	
create view imported_sunlight_house_members as
select 
  firstname as first_name,
  middlename as middle_name,
  lastname as last_name,
  name_suffix,
  nickname,
  party,
  state,
  cast(district as integer),
  gender,
  phone,
  fax,
  website,
  webform,
  congress_office,
  bioguide_id,
  votesmart_id,
  fec_id,
  govtrack_id,
  crp_id,
  twitter_id,
  congresspedia_url,
  youtube_url,
  facebook_id,
  official_rss,
  birthdate as birth_date
from
  sunlight_congress_import
where
  title = 'Rep' and
  in_office = 1;
   
	
create view imported_sunlight_senators as
select 
  firstname as first_name,
  middlename as middle_name,
  lastname as last_name,
  name_suffix,
  nickname,
  party,
  state,
  gender,
  phone,
  fax,
  website,
  webform,
  congress_office,
  bioguide_id,
  votesmart_id,
  fec_id,
  govtrack_id,
  crp_id,
  twitter_id,
  congresspedia_url,
  youtube_url,
  facebook_id,
  official_rss,
  case 
    when senate_class = 'I' then 1
    when senate_class = 'II' then 2
    when senate_class = 'III' then 3
  end as senate_class,
  birthdate as birth_date
from
  sunlight_congress_import
where
  title = 'Sen' and
  in_office = 1;



create table imported_open_states_legislators(
	leg_id		text,
	full_name	text,
	first_name	text,
	middle_name	text,
	last_name	text,
	suffixes	text,
	nickname	text,
	active		boolean,
	state		text,
	chamber		text,
	district	text,
	party		text,
	transparencydata_id	text,
	photo_url	text,
	source_created_at	timestamp,
	source_updated_at	timestamp
);


end;



\copy sunlight_congress_import(title,firstname,middlename,lastname,name_suffix,nickname,party,state,district,in_office,gender,phone,fax,website,webform,congress_office,bioguide_id,votesmart_id,fec_id,govtrack_id,crp_id,twitter_id,congresspedia_url,youtube_url,facebook_id,official_rss,senate_class,birthdate) from 'data/sunlight-congress.csv' delimiters ',' CSV;



\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ak_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/al_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ar_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/az_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ca_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/co_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ct_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/de_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/fl_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ga_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/hi_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ia_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/id_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/il_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/in_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ks_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ky_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/la_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ma_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/md_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/me_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/mi_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/mn_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/mo_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ms_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/mt_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/nc_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/nd_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ne_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/nh_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/nj_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/nm_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/nv_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ny_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/oh_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ok_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/or_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/pa_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/pr_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ri_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/sc_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/sd_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/tn_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/tx_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/ut_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/va_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/vt_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/wa_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/wi_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/wv_legislators.csv' delimiters ',' CSV;
\copy imported_open_states_legislators(leg_id,full_name,first_name,middle_name,last_name,suffixes,nickname,active,state,chamber,district,party,transparencydata_id,photo_url,source_created_at,source_updated_at) from 'data/open-states-legislator-csv-files/wy_legislators.csv' delimiters ',' CSV;




