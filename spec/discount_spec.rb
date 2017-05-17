require './models/discount'

describe Discount do

  subject { Discount.new }
  deliveries = [:express, :express, :express]
  total = 60
    it 'creates an instance of a class' do
      expect(subject).to be_a(Discount)
    end

    describe "#initalize" do
      it 'can be initialised with paraters passed as argments' do
        settings = {:discount_percent => 5,
                    :min_spend => 35,
                    :deliv_type => :standard,
                    :price_change => 4,
                    :delvery_min => 3,
                    :error_msg => "This order already has a discount"
                    }
        expect{(Discount.new(settings))}.to_not raise_error
      end

      it 'can be initialised with default parameters' do
        expect{(Discount.new)}.to_not raise_error
      end
    end

      it "can check if the order is valid for apply_percent discount" do
        expect(subject.apply_percent(total)).to eq(54)
      end

      it "can change the price of the deliviries if they are more than delivery_min" do
        expect(subject.change_price(total, deliveries)).to eq(45)
      end

      it "discounts total price with all applicable promotions" do
        expect(subject.update_total(total, deliveries)).to eq(40.5)
      end

      it "returns an error message 'This order already has a discount' by default" do
       expect(subject.error_msg).to eq('This order already has a discount')
      end



end
