#!/usr/bin/env rake
$:.unshift File.expand_path("../lib", __FILE__)

require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'
require 'tiktak'
require 'rubygems'
gem 'minitest'
require 'minitest/spec'

Rake::TestTask.new do |t|
  t.pattern = 'spec/*_spec.rb'
end

task :play do
  TikTak.main
end

task :gui, :arg1, :arg2 do |t, args|
  TikTak.gui(args[:arg1], args[:arg2])
end

task :barf, :arg1, :arg2 do |t, args|
  puts "hi"
end


