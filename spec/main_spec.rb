require './main.rb'

describe Enumerable do
    let(:array) { [1, 3, 5, 7] }
    let(:string_array) { %w[cat dog yam egg] }
    let(:range) { (1..4) }

    describe "#my_each" do
      it "It returns multiplcation of the array" do
          result = []
          array.my_each {|e| result << e * 2}
          expect(result).to eq([2,6,10,14])
      end

      it "it should return enumerator if block is not given" do
        expect(array.my_each).to be_an Enumerator
      end
    end

    describe "#my_each" do
      it "returns element index" do
          result = []
          array.my_each_with_index {|e, index| result << index}
          expect(result).to eq([0, 1, 2, 3])
      end

      it "it should return enumerator if block is not given" do
        expect(array.my_each_with_index).to be_an Enumerator
      end
    end

    describe "#my_select" do
        it "returns element index" do
            result = []
            array.my_select {|e| result << e * 2}
            expect(result).to eq([2, 6, 10, 14])
        end
  
        it "it should return enumerator if block is not given" do
          expect(array.my_select).to be_an Enumerator
        end
      
        it "returns element equal to 3" do
            result = array.my_select {|e| e == 3}
            expect(result).to eq([3])
        end

        it "returns even elements" do
            result = array.my_select {|e| e % 2 == 0}
            expect(result).to eq([])
        end
    end

    describe "#my_all?" do
      it "returns the predicate of all odd numbers" do
          result = array.my_all? {|e| e % 2 != 0}
          expect(result).to be_truthy
      end

      it "checks if all elements are divisible by 5" do
        result = array.my_all? {|e| e % 5 == 0}
        expect(result).to be_falsey
      end

      it "checks if all elements has a length of 3" do
        result = string_array.my_all? {|e| e.length == 3}
        expect(result).to be_truthy
      end
    end
end