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


   	it "attacking with no weapon deals fist multiplier x strength damage" do
      fake_fist = instance_double("Fist", use: 2)
      str = sven.instance_variable_get(:@strength) # sven's str is 10
      health = eric.instance_variable_get(:@health)
      sven.instance_variable_set( :@fists, fake_fist ) # ???
      sven.attack(eric)
      expect(eric.instance_variable_get(:@health)).to eq(health-fake_fist.use*str)
    end

  	it "attacking with a weapon runs damage_with_weapon" do
      fake_weapon = instance_double("Weapon")
      olag = Viking.new("Olag", 100, 10, fake_weapon)
      expect(olag).to receive(:damage_with_weapon).and_return(10)
      olag.attack(sven)
    end

  	it "attacking with a weapon deals weapon multiplier x strength as damage" do
      fake_weapon = instance_double("Weapon", use: 2)
      str = sven.instance_variable_get(:@strength) # sven's str is 10
      health = sven.instance_variable_get(:@health)
      olag = Viking.new("Olag", 100, 10, fake_weapon)
      olag.attack(sven)
      expect(sven.instance_variable_get(:@health)).to eq(health-fake_weapon.use*str)
    end

  	it "attacking with a bow without enough arrows uses fists instead" do
      bow = Bow.new(0)
      olag = Viking.new("Olag", 100, 10, bow)
      eric = Viking.new("Eric")
      expect(olag).to receive(:damage_with_fists).and_return(1)
      olag.attack(eric)
    end

    it "killing a viking raises an error" do
      fake_weapon = instance_double("Weapon", use: 200)
      olag = Viking.new("Olag", 1, 10, fake_weapon)
      eric = Viking.new("Eric",1)
      expect do
        olag.attack(eric)
      end.to raise_error("Eric has Died...")
    end

  end

end
