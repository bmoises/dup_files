require 'fileutils'
require 'sqlite3'
class Db
  attr_accessor :db
  def initialize(database)
    ensure_directory!(database)
    @db = SQLite3::Database.new(database) 
  end
  
  def execute(sql)
    @db.execute(sql)
  end
  
  def get_first_row(sql)
    @db.get_first_row(sql)
  end
  
  def ensure_directory!(path)
    dir = File.dirname(path)
    if !File.exists?(dir)
      FileUtils.mkdir_p dir
    end
  end
end