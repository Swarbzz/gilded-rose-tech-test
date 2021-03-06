require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("a gilded rose", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "a gilded rose"
    end

    it 'changes quality' do
      items = [Item.new("a gilded rose", 1, 5)]
      expect{ GildedRose.new(items).update_quality }.to change{ items[0].quality }
    end

    it 'sell_in decreases by 1' do
      items = [Item.new("a gilded rose", 5, 10)]
      expect{ GildedRose.new(items).update_quality }.to change{ items[0].sell_in }.by -1
    end

    it 'degrades faster when the sell-by date has past, at least twice as fast you might say' do
      items = [Item.new("a gilded rose", -1, 6)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(4)
    end

    it 'does not degrade the quality to be below 0' do
      items = [Item.new("a gilded rose", -5, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    context 'when item is Aged Brie' do

      it 'aged brie increases quality by 2 when sell_in has gone below 0' do
        items = [Item.new("Aged Brie", -1, 8)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 10
      end

      it 'aged brie does not degrade' do
        items = [Item.new("Aged Brie", 2, 1)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 2
      end

      it 'Aged brie increases in quality over time' do
        items = [Item.new("Aged Brie", 2, 6)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be > 6
      end

      it 'Aged Brie increase in quality by 1 when sell_in is still valid' do
        items = [Item.new("Aged Brie", 2, 6)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 7
      end

      it 'An items quality cannot be above 50' do
        items = [Item.new("Aged Brie", 2, 48)]
        store = GildedRose.new(items)
        50.times do
          store.update_quality
        end
        expect(items[0].quality).to eq 50
      end
    end

    context 'when item is Sulfuras' do

      it 'Sulfuras never changes its quality' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 70)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 70
      end

      it 'Sulfuras never changes its sell_in value' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 70)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to be 5
      end
    end

    context 'when item is backstage pass' do

      it 'increases quality by 1 when there are 11 days or more left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 45)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 46
      end

      it 'increases in quality by 2 when there are 10 to 6 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 45)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 47
      end

      it 'increases in quality by 3 when there are less that 6 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 45)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 48
      end

      it 'decreases to quality 0 when the sell_in day is 0' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 45)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 0
      end
    end

    context 'when an item is conjured' do

      it "goes down in quality by 2 when sell_in > 0" do
        items = [Item.new("Conjured", 4, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 8
      end

      it "goes down in quality by 4 when sell_in < 0" do
        items = [Item.new("Conjured", -1, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be 6
      end
    end

  end

end