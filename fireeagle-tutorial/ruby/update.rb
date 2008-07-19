#!/usr/bin/env ruby

require 'yaml'
require 'rubygems'
# work-around for a bug in oauth 0.2.4
require 'oauth/helper'
require 'fireeagle'

# if ARGV.empty?
#   puts "Usage: update.rb <location>"
#   exit
# end

config = YAML.load(open("fireeagle.yml").read)

unless config.has_key?("access_token") && config.has_key?("access_token_secret")
  puts "Application must be authorized: please run authorize.rb"
  exit
end

client = FireEagle::Client.new(config)

## Actual code to update

#client.update(:q => ARGV.shift)
client.lookup(:address => "10 Annandale Street", :city => "Annandale", :postal => "2038", :state => "NSW", :country => "Australia")
#client.update(:lat => 51.514565, :lon => -0.12291)
#client.update(:woeid => 12706698)

#text = client.lookup(:woeid => 1094076)
puts client.user.locations.first.woeid

text = client.lookup(:woeid => client.user.locations.first.woeid).inspect

puts text

puts "Location successfully updated."
