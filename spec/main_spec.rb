require './main.rb'

describe Enumerable do
    let(:array) { [1, 3, 5, 7] }
    let(:string_arry) { %w[cat dog yam egg] }
    let(:range) { (1..4) }

    describe "#my_each" do
      it "It returns multiplcation of the array" do
          result = []
          new_array = array.my_each {|e| result << e * 2}
          expect(result).to eq([2,6,10,14])
      end

      it "it should return enumerator if block is not given" do
        expect(array.my_each).to be_an Enumerator
      end
    end
end