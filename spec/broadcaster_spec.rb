require './models/broadcaster'

describe Broadcaster do

  subject { described_class.new 1,'tvrain' }

  it 'stores the id of the broadcaster' do
    expect(subject.id).to eq(1)
  end

  it 'stores the name' do
    expect(subject.name).to eq('tvrain')
  end

end
