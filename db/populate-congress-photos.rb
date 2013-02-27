puts 'POPULATING OFFICIAL PHOTOS'

from_folder = Rails.root.join( 'db','data','official-photos-bioguide')
to_folder = Rails.root.join('public','official_photo_store')

Dir.glob(from_folder.to_s + "/*").sort.each do |f|
  file_extension = File.extname(f)
  from_filename = File.basename(f,File.extname(f))
  official = Official.find_by_bioguide_id(from_filename)
  if (official)
    from_file = from_folder.join(from_filename+file_extension)
    to_file = to_folder.join(official.id.to_s+file_extension) 
    FileUtils.cp( from_file, to_file)
    official.photo_extension = file_extension[1..file_extension.length-1]
    official.save
  end
end 
