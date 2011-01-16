#!/usr/bin/ruby -w

require 'json'

gems = JSON::load(IO::read('gems.json'))
gems.sort! { |a, b| a['downloads'] <=> b['downloads'] }
gems.reverse!
#gems[0..200].each do |g|
#  puts "#{g['name']} #{g['downloads']} #{g['gem_uri']}"
#end
require 'pp'
$gd = {}
gems.each do |gem|
#  puts gem['name'].gsub('-', '_')
  $gd[gem['name'].gsub('-', '_')] = []
  gem['dependencies']['runtime'].each do |dep|
    $gd[gem['name'].gsub('-', '_')] << dep['name'].gsub('-','_')
  end
  gem['dependencies']['development'].each do |dep|
    $gd[gem['name'].gsub('-', '_')] << dep['name'].gsub('-','_')
  end
end


puts "strict digraph rubydeps {"

$ok = {}
def display(gem)
  return if $ok[gem]
  return if not $gd[gem]
  $gd[gem].each do |d|
    puts "#{gem} -> #{d}"
  end
  $ok[gem] = true
  $gd[gem].each do |d|
    display(d)
  end
end

gems[0..40].map { |g| g['name'] }.each do |g|
  display(g)
end
puts "}"
__END__
    puts "#{gem['name'].gsub('-','_')} -> #{dep['name'].gsub('-','_')};"

gems[0..50].each do |gem|
  gem['dependencies']['runtime'].each do |dep|
    puts "#{gem['name'].gsub('-','_')} -> #{dep['name'].gsub('-','_')};"
  end
  gem['dependencies']['development'].each do |dep|
    puts "#{gem['name'].gsub('-','_')} -> #{dep['name'].gsub('-','_')};"
  end
end
puts "}"
