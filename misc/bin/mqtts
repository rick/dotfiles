#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)+'/../lib'

require 'rubygems'
require 'mqtt'

#
# Connect to a MQTT server using SSL/TLS Client Certificate,
# send the requested payload.
#

def usage
  puts "#{$0} topic@server payload"
  puts %Q(  example: #{$0} bikeshed/hue@mqtt "{\"action\":\"color\",\"lights\":\"all\",\"color\":\"yellow\"}")
  exit 1
end

connection = ARGV.shift || usage
topic, server = connection.split('@')
payload = ARGV.shift || usage

# Note: Ruby 1.8 / 1.9 only support TLSv1
client = MQTT::Client.new(server, :ssl => true)

client.ca_file   = ENV['MQTT_CLIENT_CA']   || '/etc/ssl/ca.crt'
client.cert_file = ENV['MQTT_CLIENT_CERT'] || '/etc/ssl/localhost.crt'
client.key_file  = ENV['MQTT_KEY_FILE']    || '/etc/ssl/localhost.ckey'

client.connect do
  client.publish(topic, payload)
end
