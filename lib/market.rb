class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    vendors_with_item = []
    @vendors.each do |vendor|
      vendors_with_item << vendor if vendor.check_stock(item) > 0
    end
    vendors_with_item
  end

  def sorted_item_list
    # sorry for this mess, nerves and rushing. would refactor with more time
    inventory = @vendors.map {|vendor| vendor.inventory}
    items = inventory.map {|item| item.keys}.flatten.uniq
    sorted_items = items.sort_by {|item| item.name}
    sorted_items.map {|item| item.name}
  end

  def total_inventory
    inventory_hash = @vendors.reduce(Hash.new(0)) do |acc, vendor_info|
      # require "pry"; binding.pry
      vendor_info.inventory.map do |item, quantity|
        # require "pry"; binding.pry
        acc[item] += quantity
      end
      acc
    end
    inventory_hash
  end
end

#scratch work

# inventory = @vendors.map {|vendor| vendor.inventory}
# end
# items = items.flatten
# quantity = items.reduce(Hash.new(0)) do |result, (item, quantity)|
#   require "pry"; binding.pry
#   result
# end
