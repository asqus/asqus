class Incumbent < ActiveRecord::Base


def official_name
  name = official_first_name
  if ( official_middle_name )
    name += ' ' + official_middle_name
  end
  if (official_nickname)
    name += ' "' + official_nickname + '"'
  end
  name += ' ' + official_last_name
  return name
end

def official_name_with_abbreviated_title
  office_type_abbreviated_title + ' ' + official_name
end

def photo_filename
  Official::photo_filename(official_id,official_photo_extension)
end


def photo_path
  Official::photo_path(official_id, official_photo_extension)
end



def has_photo?
  File.exists? photo_filename
end

end
