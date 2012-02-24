$: << File.realdirpath(File.join(File.dirname(__FILE__),".."))
require 'my_files'

@db = Db.new(DB_FILE)
pp @db.execute("
SELECT * 
FROM files as f2 
WHERE md5 
IN (SELECT md5 
    FROM  files as f1
    GROUP by f1.md5 
    HAVING COUNT(f1.md5) > 1) 
    ORDER BY md5;
")
