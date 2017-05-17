require './models/delivery'

describe Delivery do

  subject { described_class.new 'standard', 20}

  it 'stores the name of the delivery' do
    expect(subject.name).to eq('standard')
  end

  it 'and stores the price' do
    expect(subject.price).to eq(20)
  end

end
