require 'digest/md5'
require 'fileutils'

class Processor
  attr_accessor :db
  
  def process(file)
    path = File.realdirpath(file)
    digest = md5(path)
    if !file_in_db?(path)
      put_in_db(path,digest)
    end
    
    #puts " --- #{file} #{md5(file)}"
  end
  
  def md5(path)
    Digest::MD5.file(path)
  end
  
  def put_in_db(path,digest)
    @db.execute("INSERT INTO files (path, md5) VALUES('#{path}','#{digest}')")
  end
  
  def file_in_db?(path)
    @db.get_first_row("SELECT * FROM files WHERE path = '#{path}'")
  end
end