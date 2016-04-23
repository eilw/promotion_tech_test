class Item

  attr_reader :price
  def initialize(product_id, price)
    @product_id = product_id
    @price = price
  end

end
