require 'minitest_helper'

class LinkifierTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Linkifier
  end
end
