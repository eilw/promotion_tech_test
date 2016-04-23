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
    discount = calculate_discount(full_price)
    present(full_price - discount)
  end

  private

  def calculate_discount(full_price)
    products = @basket.map{|item| item.id}
    @promotion_rules.reduce(0) do |sum, promotion|
      promotion.calculate_discount(products,full_price)
    end
  end

  def present(price)
    "£#{sprintf('%.2f', price)}"
  end

end
