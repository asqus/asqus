class PostalCitiesTable < ActiveRecord::Migration
  def up
        ActiveRecord::Base.connection.execute("

          drop table temp_imp_census_places;          
          alter table municipalities drop column municipality_type_id;
          drop table municipality_types;
          
          create table postal_cities (
            state_id    integer not null references states,
            name      varchar(32) not null,
            primary key   (state_id, name)
          );
          
          drop table zip_codes;
          
          create table zip_codes (
            id varchar(5) primary key,
            state_id integer not null references states,
            postal_city_name varchar not null,
            latitude            numeric(10,7),
            longitude           numeric(10,7),
            foreign key (state_id,postal_city_name) references postal_cities(state_id,name)
            );
          
          
          ")
          
          
  end

  def down
  end
end
