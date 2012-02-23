require "rubygems"
require "bundler/setup"

$: << File.expand_path(File.dirname(__FILE__))
require 'lib/db'
require 'constants'

@db = Db.new(DB_FILE)

@db.execute("DROP TABLE IF EXISTS files")
@db.execute("
CREATE TABLE files(id INTEGER PRIMARY KEY ASC, 
                   path varchar(2048),
                   md5 varchar(32),
                   created_at DATETIME
                   );
")