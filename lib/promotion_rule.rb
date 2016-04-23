class PromotionRule
  def initialize(rule)
    @rule = rule
  end

  def calculate_discount(ids, full_price)
    return calculate_total_discount(full_price) if type_total?
    return calculate_product_discount(ids) if type_product?
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
