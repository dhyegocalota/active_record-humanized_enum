$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bundler/setup'
require 'activerecord'
require 'minitest/autorun'
require 'minitest/utils'

FileList['./test/support/**/*.rb'].each { |file| require file }
