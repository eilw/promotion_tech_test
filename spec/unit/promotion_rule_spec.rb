require 'promotion_rule'

describe PromotionRule do
  let(:quantity_promotion){ described_class.new({type: "product", quantity: 2, id: "001", discount_pp: 0.75}) }
  let(:total_promotion){ described_class.new({type: "total",threshold: 60, discount_pct: 0.1}) }

  describe '#calculate_discount' do

    context 'total promotion' do
      it 'calculates a total discount if over threshold' do
        full_price = 70
        expect(total_promotion.calculate_discount(["001"], full_price)).to eq(7)
      end

      it 'no discount if not over threshold' do
        full_price = 60
        expect(total_promotion.calculate_discount(["001"], full_price)).to eq(0)
      end
    end

    context 'quantity promotion' do
      it 'applies a quanity promotion if criteria is fulfilled' do
        products = ["001","001"]
        expect(quantity_promotion.calculate_discount(products, 20)).to eq(1.5)
      end

      it 'applies a discount per product' do
        products = ["001","001", "001"]
        expect(quantity_promotion.calculate_discount(products, 20)).to eq(2.25)
      end

      it 'no discount if criteria is not fulfilled' do
        products = ["002"]
        expect(quantity_promotion.calculate_discount(products, 20)).to eq(0)
      end

      it 'order does not impact' do
        products = ["001", "002", "001"]
        expect(quantity_promotion.calculate_discount(products, 20)).to eq(1.5)
      end
    end
  end
end
