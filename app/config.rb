require_relative 'string'

Config =
  Struct.new(
    :tibber_token,
    :tibber_interval,
    :influx_schema,
    :influx_host,
    :influx_port,
    :influx_token,
    :influx_org,
    :influx_bucket,
    :influx_measurement,
    keyword_init: true,
  ) do
    def initialize(*options)
      super

      validate_url!(influx_url)
      validate_interval!(tibber_interval)
    end

    def influx_url
      "#{influx_schema}://#{influx_host}:#{influx_port}"
    end

    private

    def validate_interval!(interval)
      return if interval.is_a?(Integer) && interval.positive?

      throw "Interval is invalid: #{interval}"
    end

    def validate_url!(url)
      uri = URI.parse(url)
      return if uri.is_a?(URI::HTTP) && !uri.host.nil?

      throw "URL is invalid: #{url}"
    end

    def self.from_env(options = {})
      new(
        {}.merge(tibber_settings_from_env)
          .merge(influx_credentials_from_env)
          .merge(options),
      )
    end

    def self.influx_credentials_from_env
      {
        influx_host: ENV.fetch('INFLUX_HOST'),
        influx_schema: ENV.fetch('INFLUX_SCHEMA', 'http'),
        influx_port: ENV.fetch('INFLUX_PORT', '8086'),
        influx_token: ENV.fetch('INFLUX_TOKEN'),
        influx_org: ENV.fetch('INFLUX_ORG'),
        influx_bucket: ENV.fetch('INFLUX_BUCKET'),
        influx_measurement: ENV.fetch('INFLUX_MEASUREMENT', '').presence || 'Prices',
      }
    end

    def self.tibber_settings_from_env
      {
        tibber_token: ENV.fetch('TIBBER_TOKEN'),
        tibber_interval: ENV.fetch('TIBBER_INTERVAL', '3600').to_i,
      }
    end
  end
