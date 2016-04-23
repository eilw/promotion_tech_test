require 'item'

describe Item do
  subject(:item){described_class.new("001", 10.00)}

  describe '#price' do
    it 'returns the price of the product' do
      expect(item.price).to eq(10.00)
    end
  end
end
