require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'


describe Order do

 subject { Order.new material, discount }
 let(:material) { double :material }
 let(:standard_delivery) { double :standard_delivery, price: 10, name: :standard }
 let(:express_delivery) { double :express_delivery, price: 20, name: :express}
 let(:broadcaster_1) { double :broadcaster_1 }
 let(:broadcaster_2) { double :broadcaster_2 }
 let(:discount) { double :discount }


  it 'creates an instance of a class' do
    expect(subject).to be_a(Order)
  end


  context 'empty' do
    it 'costs nothing' do
      expect(subject.total_price).to eq(0)
    end
  end

  context 'with items' do

    it 'can be initialized with a discount' do
      expect{Order.new(material, discount)}.not_to raise_error
    end

    it 'can be initialized without a discount' do
     expect{order = Order.new(material)}.not_to raise_error
    end

    it { is_expected.to respond_to(:add).with(2).arguments }

    it "#add changes the number of elements in the array of items" do
      subject.add broadcaster_1, standard_delivery
      expect(subject.items).to include [broadcaster_1, standard_delivery]
    end



   describe "add and remove discount" do

      it "discount can be added to an existing order" do
        allow(discount).to receive(:update_total).and_return(36)
        order = Order.new (material)
        order.add broadcaster_1, express_delivery
        order.add broadcaster_2, express_delivery
        expect{order.add_discount(discount)}.not_to raise_error
        expect(order.total_cost).to eq(36)
      end

      it "discount can be removed from an exisitng order" do
        allow(discount).to receive(:update_total).and_return(40)
        subject.add broadcaster_1, express_delivery
        subject.add broadcaster_2, express_delivery
        expect{subject.remove_discount}.not_to raise_error
        expect(subject.total_cost).to eq(40)
      end

      it 'receives an error msg if a discount already exists' do
        allow(discount).to receive(:error_msg).and_return 'This order already has a discount'
        expect{subject.add_discount(discount)}.to raise_error('This order already has a discount')
      end
    end


    it 'outputs all the order data' do
      allow(material).to receive(:identifier).and_return "HON/TEST001/010"
      allow(discount).to receive(:update_total).and_return 40
      expect(subject.output).to include("HON/TEST001/010")
      expect(subject.output).to include('40')
    end

  end
end
