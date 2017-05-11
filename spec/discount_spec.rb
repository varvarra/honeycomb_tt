require './models/discount'


describe Discount do

  subject { Discount.new }

  describe 'class' do
    it 'creates an instance of a class' do
      expect(subject).to be_a(Discount)
    end
  end


end
