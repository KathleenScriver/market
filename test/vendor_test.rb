require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
  end

  def test_it_has_a_name
    vendor = Vendor.new("Rocky Mountain Fresh")

    expected = "Rocky Mountain Fresh"

    assert_equal expected, vendor.name
  end

  def test_inventory_starts_empty
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal ({}), vendor.inventory
  end

  def test_it_can_stock_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 0, vendor.check_stock("Peaches")

    vendor.stock("Peaches", 30)
    vendor.stock("Tomatoes", 12)

    assert_equal 30, vendor.check_stock("Peaches")
    assert_equal 12, vendor.check_stock("Tomatoes")
  end

end
