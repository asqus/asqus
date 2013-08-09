class AddZipCodes < ActiveRecord::Migration
  def up
    
    ActiveRecord::Base.connection.execute("
       
       create table zip_codes (
         id varchar(5) primary key,
         state_id integer not null references states,
         municipality_ansi_code integer,  
         latitude            numeric(10,7),
         longitude           numeric(10,7),  
         foreign key       (state_id,municipality_ansi_code) references municipalities(state_id,ansi_code)
       );
       
       create index zip_codes_state_municipality_idx on zip_codes(state_id,municipality_ansi_code);

       
       create table municipality_types (
         id integer primary key,
         name varchar not null
       );
         
       insert into municipality_types(id,name) values (1,'Incorporated Place');
       insert into municipality_types(id,name) values (2,'Census Designated Place');
       
       alter table municipalities add column municipality_type_id integer not null default 1 references municipality_types;
       create index municipalities_state_idx on municipalities(state_id,name);
       create index municipalities_name_idx on municipalities(name);
       drop index municipalities_ansi_uidx;
       
       
       create table temp_imp_census_places (
         state_abbreviation varchar,
         state_code integer,
         name       varchar,
         ansi_code  integer,
         place_type       varchar,
         type_code  varchar,
         counties   varchar      
       );
       
       create table temp_imp_zip_codes (
         id   varchar primary key,
         state_abbreviation varchar,
         latitude numeric(10,7),
         longitude numeric(10,7),
         name varchar,
         state_name varchar
       );
         

       
        
     ")
    
  end

  def down
    
    ActiveRecord::Base.connection.execute("
    
      drop table zip_codes;
      alter table municipalities drop column municipality_type_id;
      drop table municipality_types;   
      drop table temp_imp_census_places;
      drop table temp_imp_zip_codes;
      
    ")
    
  end
end
