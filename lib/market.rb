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

  def sell(item, quantity)
    if total_inventory[item] >= quantity
      adjust_inventory(item, quantity)
      true
    else
      false
    end
  end

  def adjust_inventory(item, quantity)
    vendors_that_sell(item).each do |vendor|
      if vendor.inventory[item] >= quantity
        vendor.inventory[item] -= quantity
        break
      else
        quantity -= vendor.inventory[item]
        vendor.inventory[item] = 0
      end
    end
  end
end
