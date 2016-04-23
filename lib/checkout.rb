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
    full_price = basket.reduce(0){|sum, item| sum + item.price}
    discount = calculate_discount(full_price)
    present(full_price - discount)
  end

  private

  attr_reader :promotion_rules

  def get_products
    basket.map{|item| item.id}
  end

  def calculate_discount(full_price)
    promotion_rules.reduce(0) do |sum, promotion|
      sum + promotion.calculate_discount(get_products,full_price-sum)
    end
  end

  def present(price)
    "£#{sprintf('%.2f', price.round(2))}"
  end

end
