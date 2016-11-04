require 'warmup'

describe Warmup do

  let(:warm) {Warmup.new}
  
  describe "#gets_shout" do
    it "shouts successfuly" do
      allow(warm).to receive(:gets).and_return("hello")
      expect(warm.gets_shout).to eq("HELLO")
    end
  end

  describe "#triple_size" do 
    it "does stuff"
  end
end