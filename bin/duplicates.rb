$: << File.realdirpath(File.join(File.dirname(__FILE__),".."))
require 'dup_files'

@db = Db.new(DB_FILE)
files = @db.execute("
SELECT * 
FROM files as f2 
WHERE md5 
IN (SELECT md5 
    FROM  files as f1
    GROUP by f1.md5 
    HAVING COUNT(f1.md5) > 1) 
    ORDER BY md5;
")

duplicates = {}
files.each{ |dup|
  duplicates[dup[2]] ||= []
  duplicates[dup[2]] << dup[1]
}

duplicates.each do |key,files|
  puts "#{key.slice(0..6)}".color(:green)
  puts "\s\s#{files.join("\n\s\s")}".color(:blue)
end