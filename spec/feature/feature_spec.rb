require 'checkout'
require 'promotion_rule'
require 'item'


describe 'checkout system feature' do
  let(:quantity_promotion){ PromotionRule.new({type: "product", quantity: 2, id: "001", discount_pp: 0.75}) }
  let(:total_promotion){ PromotionRule.new({type: "total",threshold: 60, discount_pct: 0.1}) }
  let(:promotion_rules){ [quantity_promotion,total_promotion] }
  let(:co){ Checkout.new(promotion_rules) }
  let(:lavender_heart){ Item.new("001", 9.25) }
  let(:cufflinks){ Item.new("002", 45.00) }
  let(:kids_tshirt){ Item.new("003", 19.95) }

  describe 'sample data' do
    it 'discount for total value' do
      co.scan(lavender_heart)
      co.scan(cufflinks)
      co.scan(kids_tshirt)
      price = co.total
      expect(price).to eq("£66.78")
    end

    it 'gives discount for two products' do
      co.scan(lavender_heart)
      co.scan(kids_tshirt)
      co.scan(lavender_heart)
      price = co.total
      expect(price).to eq("£36.95")
    end

    it 'gives discount for two products and total value' do
      co.scan(lavender_heart)
      co.scan(cufflinks)
      co.scan(lavender_heart)
      co.scan(kids_tshirt)
      price = co.total
      expect(price).to eq("£73.76")
    end
  end

end
