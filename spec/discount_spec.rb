require './models/discount'


describe Discount do

  subject { Discount.new }

    it 'creates an instance of a class' do
      expect(subject).to be_a(Discount)
    end

    describe "#initalize" do
      it 'can be initialised with paraters passed as argments' do
        settings = {:discount_percent => 5,
                    :min_spend => 35,
                    :deliv_type => :standard,
                    :price_change => 4,
                    :delvery_min => 3}
        expect{(Discount.new(settings))}.to_not raise_error
      end

      it 'can be initialised with default parameters' do
        expect{(Discount.new)}.to_not raise_error
      end
    end



end
