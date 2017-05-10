require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'


describe Order do
  subject { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }
  let(:broadcaster_1) {Broadcaster.new(1, 'Disney') }

  describe 'class' do
    it 'creates an instance of a class' do
      expect(subject).to be_a(Order)
    end
  end


  context 'empty' do
    it 'costs nothing' do
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'with items' do
    it 'returns the total cost of all items' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery

      expect(subject.total_cost).to eq(30)
    end
  end

  describe "#add" do
    it { is_expected.to respond_to(:add).with(2).arguments }

    it "changes the number of elements in the array of items" do
      subject.add(broadcaster_1, standard_delivery)
      expect(subject.items).to include [broadcaster_1, standard_delivery]
    end

  end


end
