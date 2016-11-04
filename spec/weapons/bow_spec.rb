require 'weapons/bow'

describe Bow do

  let(:test_bow) { Bow.new }

  describe "initialization" do

    it "arrow should be accessible" do
      expect(test_bow).to respond_to(:arrows)
    end

    it "should have 10 arrows by default" do
      test = Bow.new
      expect(test.arrows).to eq(10)
    end

    it "should equal the number of arrows its given" do
      test = Bow.new(20)
      expect(test.arrows).to eq(20)
    end

  end

  describe "#use" do

    it "should reduce arrows by 1" do
      test_bow.use
      expect(test_bow.arrows).to eq(9)
    end

    it "should not shoot 0 arrows" do
      test = Bow.new(0)
      expect do
        test.use
      end.to raise_error("Out of arrows")
    end

  end
end