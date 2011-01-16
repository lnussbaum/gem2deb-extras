#!/usr/bin/ruby -w

require 'json'

gems = []
(Dir::entries('out') - ['.', '..']).each do |f|
  begin
    gems << JSON::parse(IO::read('out/'+f))
  rescue
  end
end
File::open('gems.json','w') do |f|
  f.puts JSON::dump(gems)
end
