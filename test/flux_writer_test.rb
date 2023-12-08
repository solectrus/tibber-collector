require 'test_helper'
require 'webmock/minitest'

require 'tibber'
require 'config'

class FluxWriterText < Minitest::Test
  def test_push
    config = Config.from_env

    price_info = nil
    capture_io do
      VCR.use_cassette('tibber_success') do
        price_info = Tibber.new(config:).price_info
      end
    end

    flux_writer = FluxWriter.new(config:)
    points = flux_writer.price_info_to_points(price_info)

    points.each do |point|
      assert point.is_a?(InfluxDB2::Point)

      # The time should be in the future
      linux_time = point.instance_variable_get(:@time)

      assert_operator linux_time, :>, Time.new(2023, 12, 5, 0, 0, 0).to_i

      # The time should be always a full hour, so minutes and seconds should be zero
      time = Time.at(linux_time)

      assert_predicate time.min, :zero?
      assert_predicate time.sec, :zero?
    end
  end
end
