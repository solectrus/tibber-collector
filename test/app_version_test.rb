require 'test_helper'
require 'climate_control'

require 'app_version'

class AppVersionTest < Minitest::Test
  def test_prefers_commit_version
    with_env(COMMIT_VERSION: 'v0.10.1-3-g2d8f177', VERSION: 'develop') do
      assert_equal 'v0.10.1-3-g2d8f177', AppVersion.current
    end
  end

  def test_falls_back_to_version_when_commit_version_is_blank
    with_env(COMMIT_VERSION: '', VERSION: 'develop') do
      assert_equal 'develop', AppVersion.current
    end
  end

  def test_returns_nil_when_both_are_blank
    with_env(COMMIT_VERSION: '', VERSION: '') { assert_nil AppVersion.current }
  end

  def test_returns_nil_when_both_are_unset
    with_env(COMMIT_VERSION: nil, VERSION: nil) { assert_nil AppVersion.current }
  end

  private

  def with_env(**env, &)
    ClimateControl.modify(**env, &)
  end
end
