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
  
  CHUNK = 32
  def md5(path)
    # We will sample the file
    file = File.new(path,"r")

    size = file.size

    str = ""
    if size < (2 * CHUNK)
      str << file.read
    else
      # read begining
      str << file.read(CHUNK)

      # read middle
      if size > (5 * CHUNK)
        file.seek( (size / 4) )
        str << file.read(CHUNK)

        file.seek( (size / 2) )
        str << file.read(CHUNK)

        file.seek( (size / 4) + (size / 2) )
        str << file.read(CHUNK)
      end

      # read end
      file.seek(size-CHUNK)
      str << file.read(CHUNK)
    end
    res = Digest::MD5.hexdigest(str)
    file.close
    res
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
