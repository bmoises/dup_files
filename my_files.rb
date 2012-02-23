require "rubygems"
require "bundler/setup"

$: << File.expand_path(File.dirname(__FILE__))
require 'lib/my_files'
require 'lib/db'
require 'lib/processor'
require 'constants'


proc     = Processor.new
proc.db  = Db.new(DB_FILE)
my_files = MyFiles.new(ARGV)

my_files.files do |file|
  proc.process(file)
end

pp proc.db.execute("
SELECT * 
FROM files as f2 
WHERE md5 
IN (SELECT md5 
    FROM  files as f1
    GROUP by f1.md5 
    HAVING COUNT(f1.md5) > 1) 
    ORDER BY md5;
")

