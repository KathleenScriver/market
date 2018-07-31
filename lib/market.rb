class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.has_key?(item)
    end
  end

  def sorted_item_list
    @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq.sort
  end

  def total_inventory
    sorted_item_list.inject(Hash.new(0)) do |total, item|
      @vendors.each do |vendor|
        total[item] += vendor.inventory[item]
      end
      total
    end
  end
end
