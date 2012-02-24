$: << File.realdirpath(File.join(File.dirname(__FILE__),".."))
require 'my_files'

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

pp files.inject({}){ |newhash, val|
  pp val
  newhash[val[2]] = [] if !newhash[val[2]] 
  newhash[val[2]] << val[1]
  # newhash[k] = v
}