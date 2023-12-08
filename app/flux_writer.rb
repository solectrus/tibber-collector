require 'influxdb-client'
require 'time'

class FluxWriter
  def initialize(config:)
    @config = config
  end

  attr_reader :config

  def self.push(config:, price_info:)
    new(config:).push(price_info)
  end

  def price_info_to_points(price_info)
    (price_info.today + price_info.tomorrow).map { |p| price_to_point(p) }
  end

  def price_to_point(price)
    InfluxDB2::Point.new(
      name: influx_measurement,
      time: Time.parse(price.starts_at).to_i,
      fields: {
        amount: price.total,
        level: price.level,
      },
    )
  end

  def push(price_info)
    return unless price_info

    write_api.write(
      data: price_info_to_points(price_info),
      bucket: config.influx_bucket,
      org: config.influx_org,
    )
  end

  private

  def influx_measurement
    config.influx_measurement
  end

  def influx_client
    @influx_client ||=
      InfluxDB2::Client.new(
        config.influx_url,
        config.influx_token,
        use_ssl: config.influx_schema == 'https',
        precision: InfluxDB2::WritePrecision::SECOND,
      )
  end

  def write_api
    @write_api ||= influx_client.create_write_api
  end
end
