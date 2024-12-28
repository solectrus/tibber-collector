require 'simplecov'
SimpleCov.start

require 'minitest/autorun'

require File.expand_path './support/vcr_setup.rb', __dir__

def mock_env(partial_env_hash)
  old = ENV.to_hash
  ENV.update partial_env_hash
  begin
    yield
  ensure
    ENV.replace old
  end
end

# Silence deprecation warnings caused by the `influxdb-client` gem
Warning[:deprecated] = false
