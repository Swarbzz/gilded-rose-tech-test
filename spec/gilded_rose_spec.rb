require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("a gilded rose", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "a gilded rose"
    end

    it 'changes quality' do
      items = [Item.new("a gilded rose", 1, 5)]
      expect{ GildedRose.new(items).update_quality() }.to change{ items[0].quality }
    end

    it 'degrades faster when the sell-by date has past, at least twice as fast you might say' do
      items = [Item.new("a gilded rose", -5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(8)
    end
  end

end