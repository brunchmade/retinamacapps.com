require 'html/proofer'
require 'rubygems'
require 'rake'
require 'rdoc'
require 'date'
require 'yaml'
require 'tmpdir'
require 'jekyll'

desc "Tests links and images"
task :test do
  sh "bundle exec jekyll build"
  HTML::Proofer.new("./_site", {:check_html => true, :alt_ignore => [/.*/]}).run
end