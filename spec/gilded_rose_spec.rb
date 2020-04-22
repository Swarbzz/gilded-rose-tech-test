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

    it 'does not degrade the quality to be below 0' do
      items = [Item.new("a gilded rose", -5, 10)]
      store = GildedRose.new(items)
      50.times do
        store.update_quality()
      end
      expect(items[0].quality).not_to eq -1
    end

    it 'aged brie does not degrade' do
      items = [Item.new("Aged Brie", 2, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end

    it 'Aged brie increases in quality over time' do
      items = [Item.new("Aged Brie", 2, 6)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be > 6
    end

    it 'Aged Brie increase in quality by 1' do
      items = [Item.new("Aged Brie", 2, 6)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be 7
    end

    it 'An items quality cannot be above 50' do
      items = [Item.new("Aged Brie", 2, 48)]
      store = GildedRose.new(items)
      4.times do
        store.update_quality()
      end
      expect(items[0].quality).not_to eq 52
    end

    it 'Sulfuras never changes its quality' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 70)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be 70
    end

    it 'Sulfuras never changes its sell_in value' do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 70)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to be 5
    end
  end

end