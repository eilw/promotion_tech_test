class Checkout
  def initialize(promotion_rules)
    @basket = []
    @promotion_rules = promotion_rules
  end

  def scan(item)
    @basket << item
  end

  def basket
    @basket.dup
  end

  def total
    full_price = @basket.reduce(0){|sum, item| sum + item.price}
    discount = calculate_discounts(full_price)
    present(full_price - discount)
  end

  private

  def calculate_discounts(full_price)
    discount = 0
    @promotion_rules.each do |promotion|
      discount += promotion.calculate_discount('total', full_price)
    end
    discount

  end

  def present(price)
    "£#{sprintf('%.2f', price)}"
  end

end
