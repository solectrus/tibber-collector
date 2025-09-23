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
      assert_kind_of InfluxDB2::Point, point

      # The time should be in the future
      linux_time = point.instance_variable_get(:@time)

      assert_operator linux_time, :>, Time.new(2023, 12, 5, 0, 0, 0).to_i

      # The time should be always a quarter hour, so minutes should be 0, 15, 30, or 45 and seconds should be zero
      time = Time.at(linux_time)

      assert_includes [0, 15, 30, 45], time.min
      assert_predicate time.sec, :zero?
    end
  end
end
