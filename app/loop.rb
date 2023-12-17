require 'net/http'
require 'influxdb-client'

require_relative 'flux_writer'
require_relative 'tibber'

class Loop
  def initialize(config:)
    @config = config
  end

  attr_reader :config

  def self.start(config:, max_count: nil)
    new(config:).start(max_count)
  end

  def start(max_count)
    self.count = 0

    loop do
      self.count += 1

      puts "##{self.count} - #{Time.now}"

      push_to_influx(pull_from_tibber)
      break if max_count && count >= max_count

      puts "  Sleeping for #{config.tibber_interval} seconds ..."
      sleep config.tibber_interval
      puts
    end
  end

  private

  attr_accessor :count

  def pull_from_tibber
    print '  Fetching prices from Tibber ... '
    Tibber.new(config:).price_info
  end

  def push_to_influx(price_info)
    return unless price_info

    print '  Pushing prices to InfluxDB ... '
    FluxWriter.push(config:, price_info:)
    puts 'OK'
  end
end
