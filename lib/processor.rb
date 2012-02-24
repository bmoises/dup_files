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
  end
  
  def md5(path)
    Digest::MD5.file(path)
  end
  
  module FileTable
    def self.columns
      @@columns ||= %w(path md5 created_at modified_at)
    end
  end
  
  def put_in_db(path,digest)
    vals = [path , 
            digest, 
            File.ctime(path), 
            File.mtime(path)].join("','")
    
    @db.execute("INSERT INTO files (#{FileTable.columns.join(",")}) VALUES('#{vals}')")
  end
  
  def file_in_db?(path)
    @db.get_first_row("SELECT * FROM files WHERE path = '#{path}'")
  end
end