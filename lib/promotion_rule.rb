class PromotionRule
  def initialize(rule)
    @rule = rule
  end

  def calculate_discount(ids, full_price)
    discount = calculate_total_discount(full_price) if type_total?
    discount = calculate_product_discount(ids) if type_product?
    discount
  end

  private

  attr_reader :rule

  def calculate_total_discount(full_price)
    full_price > rule[:threshold] ? full_price * rule[:discount_pct] : 0
  end

  def calculate_product_discount(ids)
    quantity = ids.select{|id| id == rule[:id]}.length
    quantity >= rule[:quantity] ? rule[:discount_pp] * quantity : 0
  end

  def type_total?
    rule[:type] == "total"
  end

  def type_product?
    rule[:type] == "product"
  end
end
