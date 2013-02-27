
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
"create index joined_official_terms_office_idx on joined_official_terms(office_id)"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_official_idx on joined_official_terms(official_id)"
)

ActiveRecord::Base.connection.execute( 
"create index joined_official_terms_office_type_idx on joined_official_terms(office_type_id)"
)

ActiveRecord::Base.connection.execute(
"create index joined_official_terms_polity_idx on joined_official_terms(polity_type, polity_id)"
)

ActiveRecord::Base.connection.execute(
"create or replace function joined_official_terms_refresh_row( id integer ) 
returns void 
security definer 
language 'plpgsql' as $$ 
begin 
  delete from joined_official_terms jot where jot.id = id; 
  insert into joined_official_terms select *, false, null from joined_official_terms_view jot where jot.id = id; 
  end 
$$")

