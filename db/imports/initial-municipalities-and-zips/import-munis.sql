\copy temp_imp_census_places(state_abbreviation, state_code, ansi_code, name, type, type_code, counties) from 'data/census-national-place-file.psv' delimiters '|' CSV;
