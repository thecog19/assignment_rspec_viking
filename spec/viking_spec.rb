require 'viking'

describe Viking do

  describe "initialization" do

    it "Vikings can be named" do
      sven = Viking.new("Sven")
      expect(sven.instance_variable_get(:@name)).to eq("Sven")
    end

  end

end