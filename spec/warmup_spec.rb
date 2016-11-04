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

    let(:arr_double) do
      double("Array", :size => 2)
    end

    it "triples the size of an array" do
      expect(warm.triple_size(arr_double)).to eq(6)
    end

  end

  describe "#calls_some_methods" do

    it "raises an error when the string is empty" do 

      str_double = double("String", :empty? => true)
      expect do 
        warm.calls_some_methods(str_double)
      end.to raise_error("Hey, give me a string!")

    end 

    it "calls upcase on string" do 

      #str_double = double("String", :empty? => false, :upcase! => "HELLO")

      str_double = double("String" , empty?: false)
      expect(str_double).to receive(:upcase!).and_return("foo")
      warm.calls_some_methods(str_double)

    end

    it "calls reverse on string" do 

      str_double = double("String" , empty?: false, upcase!: "whatever", reverse!: "hi")
      expect(str_double.upcase!).to receive(:reverse!).and_return("foo")
      warm.calls_some_methods(str_double)

    end

    it "returns 'I am unrelated'" do
      expect(warm.calls_some_methods("test")).to eq("I am unrelated")
    end

  end

end