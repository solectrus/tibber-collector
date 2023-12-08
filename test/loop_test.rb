require 'test_helper'
require 'loop'
require 'config'

class LoopTest < Minitest::Test
  def test_start_successful
    config = Config.from_env

    cassettes = [{ name: 'loop_success' }]

    out, err =
      capture_io do
        VCR.use_cassettes(cassettes) { Loop.start(config:, max_count: 2) }
      end

    assert_match(/Fetching prices from Tibber/, out)
    assert_match(/Pushing prices to InfluxDB/, out)
    assert_empty(err)
  end

  def test_start_fail
    config = Config.from_env

    stub_request(:post, Tibber::BASE_URL).to_return(status: 500)

    out, err = capture_io { Loop.start(config:, max_count: 1) }

    assert_match(/Error 500/, out)
    assert_empty(err)
  end
end
