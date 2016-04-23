require 'item'

describe Item do
  subject(:item){described_class.new("001", 10.00)}

  describe '#price' do
    it 'returns the price of the product' do
      expect(item.price).to eq(10.00)
    end
  end
  describe '#id' do
    it 'returns the id of the product' do
      expect(item.id).to eq("001")
    end
  end
end
