#!/usr/bin/env ruby
# encoding: utf-8

# this fixes some encoding issues running this on OS X 10.11
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative 'bundle/bundler/setup'
require 'alfred'
require 'tado'

def tado_username
  output = `security find-generic-password -l tado-api`
  if output =~ /The specified item could not be found in the keychain/
    nil
  else
    output.split("\n").map{|line| line.match(/\s*\"acct\"<blob>=\"(.*)\"/)}.compact.first[1]
  end
end

def tado_password
  output = `security find-generic-password -l tado-api -w`
  if output =~ /The specified item could not be found in the keychain/
    nil
  else
    output.chomp
  end
end

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  if tado_username == nil || tado_password == nil
    fb.add_item({
      :uid      => ""                     ,
      :title    => "Please confiugre your Tado° credentials. See README for that.",
      :subtitle => "Enter for documentation",
      :arg      => "https://github.com/wrtsprt/alfred2-tado-control" ,
      :valid    => "yes"
    })
  else
    tado = Tado.new(tado_username, tado_password)

    current_temperature = tado.current_temperature
    heating_on = tado.heating_on?

    fb.add_item({
      :uid      => ""                     ,
      :title    => "#{current_temperature}°C, heating on: #{heating_on}",
      :subtitle => ""        ,
      :arg      => "" ,
      :valid    => "yes"                  ,
    })
  end

  if ARGV[0].eql? "failed"
    alfred.with_rescue_feedback = true
    raise Alfred::NoBundleIDError, "Wrong Bundle ID Test!"
  end

  puts fb.to_xml(ARGV)
end



