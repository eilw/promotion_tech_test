require 'checkout'

describe Checkout do
  let(:lavender_heart){double('item', price: 10.00)}
  let(:cufflinks){double('item', price: 20.50)}
  let(:total_promotion){double('promotion', calculate_discount: 0)}
  let(:promotion_rules){[total_promotion]}
  subject(:co){described_class.new(promotion_rules)}

  describe '#scan' do
    it 'adds a scanned item to a basket' do
      co.scan(lavender_heart)
      expect(co.basket).to include(lavender_heart)
    end
  end

  describe '#total' do
    it 'sums up the price of each item in the basket' do
      co.scan(lavender_heart)
      co.scan(cufflinks)
      expect(co.total).to eq("£30.50")
    end

    it 'applies a total discount' do
      allow(total_promotion).to receive(:calculate_discount){6.15}
      3.times{co.scan(cufflinks)}
      expect(co.total).to eq("£55.35")
    end

  end
end
