
require_relative '../lib/cart'
require_relative '../lib/item'

RSpec.describe Cart do
  it 'Given have minus price, should be error message "price must be positive"' do
    expect {
      Item.new(name: "Apple", price: -200)
      }.to raise_error(RuntimeError, 'price must be positive')
  end
end
