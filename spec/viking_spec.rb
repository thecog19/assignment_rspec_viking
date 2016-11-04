require 'viking'

describe Viking do

  let(:sven) { Viking.new("Sven", 150) } # remove?

  describe "initialization" do

    it "Vikings can be named" do
      sven = Viking.new("Sven")
      expect(sven.instance_variable_get(:@name)).to eq("Sven")
    end

    it "health can be set for Vikings" do
      sven = Viking.new("Sven", 150)
      expect(sven.instance_variable_get(:@health)).to eq(150)      
    end

    it "health cannot be overwritten after initialization" do
      expect do
        sven.health = 200
      end.to raise_error(NoMethodError)
    end

    it "weapon starts out at nil by default" do
      expect(sven.instance_variable_get(:@weapon)).to be_nil
    end

  end

  describe "#pick_up_weapon" do 

  	it "cannot pick up a non-weapon" do
      expect do 
        sven.pick_up_weapon([])
      end.to raise_error("Can't pick up that thing")
    end

  	it "replaces a Viking's existing weapon" do
      dumb_weapon = instance_double("Weapon", is_a?: true)
      sven.pick_up_weapon(dumb_weapon)
      expect(sven.instance_variable_get(:@weapon)).to eq(dumb_weapon)
    end

  end


  describe "#drop_weapon" do 

  	it "dropping a weapon leaves a Viking weaponless" do
      dumb_weapon = instance_double("Weapon")
      sven = Viking.new("Sven", 150, 10, dumb_weapon)
      sven.drop_weapon
      expect(sven.instance_variable_get(:@weapon)).to be_nil            
    end

  end

  describe "#receive_attack" do

  	it "health is reduced by a specific amount" do 
      sven.receive_attack(10)
      expect(sven.instance_variable_get(:@health)).to eq(140)
    end

  	it "calls take_damage" do
      expect(sven).to receive(:take_damage)
      sven.receive_attack(10)
    end

  end

  describe "#attack" do
    let(:eric) {Viking.new("eric", 100, 14)} 

    it "attacking another Viking causes the recipient's health to drop" do
      sven.attack(eric)
      expect(eric.instance_variable_get(:@health)).to be < 100 
    end


  	it "attacking another Viking calls that Viking's take_damage" do
      expect(eric).to receive(:take_damage)
      sven.attack(eric)
    end

   	it "attacking with no weapon runs damage_with_fists" do
      expect(sven).to receive(:damage_with_fists).and_return(10)
      sven.attack(eric)
    end

   	it "attacking with no weapon deals fist's multiplier times strength damage" do
      str = sven.instance_variable_get(:@strength)
      allow(sven.fists).to receive(:use).and_return(2) 
      sven.attack(eric)
    end
   

  # 	it "attacking with a weapon runs damage_with_weapon"

  # 	it "attacking with a weapon deals weapon's multiplier times strength as damage"

  # 	it "attacking with a bow without enough arrows uses fists instead"

  # 	it "killing a viking raises an error" 

  end

end