require 'minitest_helper'

class LinkifierSpec < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Linkifier
  end
end
