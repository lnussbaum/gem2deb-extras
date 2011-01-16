#!/usr/bin/ruby -w

require 'rubygems'
require 'faster'
require 'persistent'
require 'threadpool'

gems = Marshal.load(IO::read('latest_specs.4.8'))
#urls = gems.map { |g| "http://rubygems.org/api/v1/gems/#{g[0]}.json" }
tp = ThreadPool::new(100)
gems.each do |g|
  g = g[0]
  tp.process do
    uri = URI.parse "http://rubygems.org/api/v1/gems/#{g}.json"
    http = Net::HTTP::Persistent.new
    stuff = http.request uri
    File::open("#{g}.json", 'w') do |f|
      f.puts stuff.body
    end
  end
end
tp.join
