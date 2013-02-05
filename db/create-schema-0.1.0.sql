


create table nations (
	id	serial primary key,
	name text not null,
	created_at timestamp not null default now(),
	updated_at timestamp not null default now()
);

create table states (
	id	serial primary key,
	name text not null,
	abbreviation char(2) not null,
	is_state boolean not null default 'true',
	created_at timestamp not null default now(),
	updated_at timestamp not null default now()
);

create unique index states_name_uidx on states(name);
create unique index states_abbreviation_uidx on states(abbreviation);
	
create table congressional_districts (
	id				serial primary key,
	district_number	integer not null,
	state_id		integer not null references states,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index congressional_districts_uidx on congressional_districts( state_id, district_number);
	
create table counties (
	id 				serial primary key,
	name			text not null,
	state_id		integer not null references states,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index counties_uidx on counties(state_id, name);
	
create table municipalities (
	id				serial primary key,
	name			text not null,
    state_id		integer not null references states,
	created_at		timestamp not null default now(),
	updated_at 		timestamp not null default now()
);

create unique index municipalities_uidx on municipalities(state_id, name);

create table wards (
	id				serial primary key,
	municipality_id	integer not null references municipalities,
	ward_number		integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index wards_uidx on wards(municipality_id, ward_number);
	
create table state_house_districts (
	id				serial primary key,
	state_id		integer references states,
	district_number	integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);
	
create unique index state_house_districts_uidx on state_house_districts(state_id,district_number);
	
create table state_senate_districts (
	id				serial primary key,
	state_id		integer references states,
	district_number	integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index state_senate_districts_uidx on state_senate_districts(state_id,district_number);
	
		
create table office_types (
	id				serial primary key,
	description		text not null,
	polity_type		text not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index office_types_polity_type_idx on office_types(id, polity_type);
	
create table offices (
	id				serial primary key,
	name			varchar(64) not null,
	office_type_id	integer not null references office_types,
	polity_type		text not null,
	polity_id		integer not null,
	seat_discriminator	integer not null default 0,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now(),
	foreign key 	(office_type_id, polity_type) references office_types(id, polity_type)
);

create unique index offices_uidx on offices(polity_type, polity_id, office_type_id, seat_discriminator);
	
create table parties (
	id					integer primary key,
	name				text not null,
	member_noun			text not null,
	abbreviation		text not null
);

insert into parties(id, name, member_noun, abbreviation ) values (0, 'Independent', 'Independent', 'I');
insert into parties(id, name, member_noun, abbreviation ) values (1, 'Democratic', 'Democrat', 'D');
insert into parties(id, name, member_noun, abbreviation ) values (2, 'Republican', 'Republican', 'R');
	
create table officials (
	id					serial primary key,
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
	official_rss		varchar(256),
	created_at			timestamp not null default now(),
	updated_at			timestamp not null default now()
);

create index officials_name_idx on officials(last_name, first_name, middle_name );
create unique index officials_bioguide_uidx on officials(bioguide_id);
create unique index officials_votesmart_uidx on officials(votesmart_id);
create unique index officials_facebook_uidx on officials(facebook_id);
			
create table terms (
	id				serial primary key,
	name			varchar (40),
	from_date		date not null,
	to_date			date not null,
	standard		boolean not null,
	office_type_id	integer references office_types,
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


create view incumbent_officials as
	select
	    official_terms.id as official_term_id,
	    offices.id as office_id,
	    officials.id as official_id
	from
		official_terms,
		officials,
		terms,
		offices
	where
	    official_terms.official_id = officials.id and
	    official_terms.office_id = offices.id and
	    official_terms.term_id = terms.id and
	    terms.from_date <= now() and
	    terms.to_date >= now();


create type sex as enum ('Male','Female');
	
create table users (
	id						serial primary key,
	email					varchar(255),
	encrypted_password		text,
	reset_password_token	text,
	reset_password_sent_at	timestamp,
	remember_created_at		timestamp,
	sign_in_count			integer not null default 0,
	current_sign_in_at		timestamp,
	current_sign_in_ip		varchar(40),
	last_sign_in_at			timestamp,
	last_sign_in_ip			varchar(40),
	name					varchar(40),
	address1				varchar(128),
	address2				varchar(128),
	city					varchar(32),
	state					varchar(2),
	zip						varchar(10),
	state_id				integer references states,
	municipality_id			integer references municipalities,
	county_id				integer references counties,
	congressional_district_number	integer,
	state_senate_district_number	integer, 
	state_house_district_number		integer,
	latitude				numeric(10,7),
	longitude				numeric(10,7),
	staff_official_id		integer references officials,
	facebook_current_location	text,
	birth_date				date,
	sex						sex,
	created_at				timestamp not null default now(),
	updated_at				timestamp not null default now(),
	foreign key 	        (state_id, congressional_district_number) references congressional_districts(state_id, district_number),
	foreign key				(state_id, state_senate_district_number) references state_senate_districts(state_id, district_number),
	foreign key	            (state_id, state_house_district_number) references state_house_districts(state_id, district_number)
);

create unique index users_email_uidx on users(email);
create unique index users_reset_password_token_uidx on users(reset_password_token);
	


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
	provider 	varchar(40) not null,
	uid 		varchar(40) not null,
	token		varchar(64) not null,
	created_at	timestamp not null default now(),
	updated_at	timestamp not null default now()
);

create index authentications_token_idx on authentications(token);
create index authentications_uid_idx on authentications(uid);
create index authentications_user_id_idx on authentications(user_id);


create table issues (
	id				serial primary key,
	title			varchar(64) not null,
	poller_type		text not null,
	poller_id		integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index issues_uidx on issues(poller_type, poller_id, title);


create table quick_poll_types (
	id				serial primary key,
	name			varchar(32) not null
);

insert into quick_poll_types( id, name ) values (1, 'Public');
insert into quick_poll_types( id, name ) values (2, 'Private');
	
		
create table poll_workflow_states (
	id				serial primary key,
	name			varchar(32) not null
);

create table quick_polls (
	id				serial primary key,
	title			varchar(64) not null,
	body			text not null,
	quick_poll_type_id integer not null references quick_poll_types,
	poll_workflow_state_id	integer not null references poll_workflow_states,
	issue_id		integer not null references issues,
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
	id				integer primary key,
	tag				varchar(32) not null,
	context			varchar(32) not null default 'main',
	taggable_type	text not null,
	taggable_id		integer not null,
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index tags_uidx on tags(tag,context,taggable_type,taggable_id);
create index tags_taggable_idx on tags( taggable_type, taggable_id );
	

create table user_groups (
	id				serial primary key,
	user_id			integer not null,
	group_type		text not null,
	group_id		integer not null,
	role			text not null default 'member',
	created_at		timestamp not null default now(),
	updated_at		timestamp not null default now()
);

create unique index user_groups_uidx on user_groups(user_id, group_type, group_id, role);
create index user_groups_group_idx on user_groups(group_id);


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

\copy sunlight_congress_import(title,firstname,middlename,lastname,name_suffix,nickname,party,state,district,in_office,gender,phone,fax,website,webform,congress_office,bioguide_id,votesmart_id,fec_id,govtrack_id,crp_id,twitter_id,congresspedia_url,youtube_url,facebook_id,official_rss,senate_class,birthdate) from 'sunlight-congress.csv'delimiters ',' CSV;
