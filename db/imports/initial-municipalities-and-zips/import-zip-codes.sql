\copy temp_imp_zip_codes(id,state_abbreviation,latitude,longitude,name,state_name) from 'data/zip-codes.csv' delimiters ',' CSV;
update temp_imp_zip_codes set state_abbreviation = ltrim(state_abbreviation,' ');
update temp_imp_zip_codes set state_abbreviation = rtrim(state_abbreviation,' ');
update temp_imp_zip_codes set name = ltrim(name,' ');
update temp_imp_zip_codes set name = rtrim(name,' ');