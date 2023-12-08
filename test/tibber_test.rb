require 'test_helper'
require 'webmock/minitest'

require 'tibber'
require 'config'

class TibberTest < Minitest::Test
  def test_price_info_success
    config = Config.from_env

    VCR.use_cassette('tibber_success') do
      out, err =
        capture_io do
          price_info = Tibber.new(config:).price_info

          assert price_info.today.is_a?(Array)

          price_info.today.each do |p|
            assert p.starts_at.is_a?(String)
            assert p.total.is_a?(Float)
          end
        end

      assert_match(/OK/, out)
      assert_empty(err)
    end
  end

  def test_price_info_invalid_token
    config = Config.from_env(tibber_token: 'invalid_token')

    VCR.use_cassette('tibber_invalid_token') do
      out, err = capture_io { Tibber.new(config:).price_info }

      assert_match(/Error Context creation failed: invalid token/, out)
      assert_empty(err)
    end
  end

  def test_price_info_error500
    config = Config.from_env

    stub_request(:post, Tibber::BASE_URL).to_return(status: 500)

    out, err = capture_io { Tibber.new(config:).price_info }

    assert_match(/Error 500/, out)
    assert_empty(err)
  end

  def test_dump_schema
    VCR.use_cassette('tibber_schema') do
      config = Config.from_env
      Tibber.new(config:).dump_schema
    end
  end
end
