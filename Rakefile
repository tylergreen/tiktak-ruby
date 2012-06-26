# #!/usr/bin/env rake
# require "bundler/gem_tasks"

$:.unshift File.expand_path("../lib", __FILE__)

require 'rake'
require 'rake/testtask'
require 'tiktak'

Rake::TestTask.new do |t|
  t.pattern = 'spec/*_spec.rb'
end

task :play do
  TikTak.main
end


	 

