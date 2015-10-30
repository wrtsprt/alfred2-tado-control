#!/usr/bin/env ruby
# encoding: utf-8

# this fixes some encoding issues running this on OS X 10.11
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative 'bundle/bundler/setup'
require 'alfred'
require 'tado'


Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback


  tado = Tado.new(TADO_USERNAME, TADO_PASSWORD)

  fb.add_item({
    :uid      => ""                     ,
    :title    => "Hello"          ,
    :subtitle => "world!"        ,
    :arg      => "A test feedback Item" ,
    :valid    => "yes"                  ,
  })

  if ARGV[0].eql? "failed"
    alfred.with_rescue_feedback = true
    raise Alfred::NoBundleIDError, "Wrong Bundle ID Test!"
  end

  puts fb.to_xml(ARGV)
end



