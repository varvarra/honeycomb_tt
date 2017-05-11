
describe 'Feature tests' do

  let(:order) { Order.new material}
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }
  let(:broadcaster_1) { Broadcaster.new(1,'Viacom')}
  let(:broadcaster_2) { Broadcaster.new(2,'Disney')}
  let(:broadcaster_3) { Broadcaster.new(3,'Discovery')}
  let(:discount) { Discount.new }

  context 'for companies to use services offered by Honeycomb ' do

    it 'it is possible to add broadcasters with a delivery to the order' do
     expect { order.add(broadcaster_1, standard_delivery) }.to_not raise_error
   end

   before do
     order.add broadcaster_1, standard_delivery
     order.add broadcaster_2, express_delivery
     order.add broadcaster_3, express_delivery
   end

   it "the total price is unchanged unless discount is applied" do
     expect(order.total_price).to eq(50)
   end

   describe "with discounts" do

     it "possible adding different discounts to order" do
       
     end


   end




  end
end
