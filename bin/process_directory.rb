$: << File.realdirpath(File.join(File.dirname(__FILE__),".."))
require 'my_files'

proc     = Processor.new
proc.db  = Db.new(DB_FILE)
my_files = MyFiles.new(ARGV)

my_files.files do |file|
  proc.process(file)
end

