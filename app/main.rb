#!/usr/bin/env ruby

require 'dotenv/load'
require_relative 'loop'
require_relative 'config'

# Flush output immediately
$stdout.sync = true

puts 'Tibber collector for SOLECTRUS, ' \
       "Version #{ENV.fetch('VERSION', '<unknown>')}, " \
       "built at #{ENV.fetch('BUILDTIME', '<unknown>')}"
puts 'https://github.com/solectrus/tibber-collector'
puts 'Copyright (c) 2023-2025 Georg Ledermann, released under the MIT License'
puts "\n"

config = Config.from_env

puts "Using Ruby #{RUBY_VERSION} on platform #{RUBY_PLATFORM}"
puts "Pulling from #{Tibber::BASE_URL} every #{config.tibber_interval} seconds"
puts "Pushing to InfluxDB at #{config.influx_url}, " \
       "bucket #{config.influx_bucket}, " \
       "measurement #{config.influx_measurement}"
puts "\n"

Loop.start(config:)
