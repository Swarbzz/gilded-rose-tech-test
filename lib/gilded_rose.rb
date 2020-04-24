require_relative 'item'

class GildedRose

    def initialize(items)
      @items = items
    end
  
    def update_quality()
      @items.each do |item|
        update_sell_in(item, -1) unless is_sulfuras?(item)
        if !is_aged_brie?(item) || !is_backstage_passes?(item) || !is_sulfuras?(item)
          new_quality(item, 1)
          if is_backstage_passes?(item) && item.sell_in < 11
            new_quality(item, 1)
          end
          if is_backstage_passes?(item) && item.sell_in < 6
            new_quality(item, 1)
          end
        else
          new_quality(item, -1)
        end
        if item.sell_in < 0
          if is_aged_brie?(item)
            new_quality(item, 1)
          else
            if is_backstage_passes?(item) || is_sulfuras?(item)
              item.quality = item.quality - item.quality
            else
            new_quality(item, - 3)
            end
          end
        end
      end
    end

    private

    def sell_in_passed?
      item.sell_in < 0
    end
  
    def new_quality(item, amount)
      if is_in_quality_range?(item)
        item.quality += amount
      end
    end
  
    def update_sell_in(item, amount)
      item.sell_in += amount
    end
  
    def is_in_quality_range?(item)
      item.quality > 0 && item.quality < 50
    end
  
    def is_aged_brie?(item)
      item.name == "Aged Brie"
    end
  
    def is_sulfuras?(item)
      item.name == "Sulfuras, Hand of Ragnaros"
    end
  
    def is_backstage_passes?(item)
      item.name == "Backstage passes to a TAFKAL80ETC concert"
    end
end
  