#!/usr/bin/ruby -w

require 'json'

gems = JSON::load(IO::read('gems.json'))
gems.sort! { |a, b| a['downloads'] <=> b['downloads'] }
gems.reverse!
gems[0..200].each do |g|
  puts "#{g['name']} #{g['downloads']} #{g['gem_uri']}"
end
