require 'viking'

describe Viking do

  describe "initialization" do

    it "Vikings can be named" do
      sven = Viking.new("Sven")
      expect(sven.instance_variable_get(:@name)).to eq("Sven")
    end

    it "health can be set for Vikings"

    it "health cannot be overwritten after initialization"

    it "weapon starts out at nil by default" 

  end

  describe "#pick_up_weapon" do 

  	it "cannot pick up a non-weapon"

  	it "replaces a Viking's existing weapon"

  end


  describe "#drop_weapon" do 

  	it "dropping a weapon leaves a Viking weaponless"

  end

  describe "#receive_attack" do

  	it "health is reduced by a specific amount"

  	it "calls take_damage" # expect...to receive...

  end

  describe "#attack" do

  	it "attacking another Viking causes the recipient's health to drop"

  	it "attacking another Viking calls that Viking's take_damage"

  	it "attacking with no weapon runs damage_with_fists"

  	it "attacking with no weapon deals fist's multiplier times strength damage"

  	it "attacking with a weapon runs damage_with_weapon"

  	it "attacking with a weapon deals weapon's multiplier times strength as damage"

  	it "attacking with a bow without enough arrows uses fists instead"

  	it "killing a viking raises an error" 

  end

end