require_relative 'item'

class GildedRose

  MAX_QUALITY_LIMIT = 50
  MIN_QUALITY_LIMIT = 0
  PASS_FIRST_STRIKE = 11
  PASS_SECOND_STRIKE = 6

    def initialize(items)
      @items = items
    end
  
    def update_quality
      @items.each do |item|
        update_sell_in(item, -1) unless is_sulfuras?(item)
        new_quality(item, -1) unless is_unique?(item)

        if is_unique?(item)
          new_quality(item, -2) if is_conjured?(item)
          new_quality(item, 1) if is_aged_brie?(item) || is_backstage_passes?(item) || is_sulfuras?(item)
          new_quality(item, 1) if is_backstage_passes?(item) && item.sell_in < PASS_FIRST_STRIKE
          new_quality(item, 1) if is_backstage_passes?(item) && item.sell_in < PASS_SECOND_STRIKE
        end

        if item.sell_in < MIN_QUALITY_LIMIT
          new_quality(item, -1) unless is_unique?(item)
          new_quality(item, -2) if is_conjured?(item)
          new_quality(item, 1) if is_aged_brie?(item)
          item.quality = MIN_QUALITY_LIMIT if is_backstage_passes?(item)
        end

      end
    end

    private

    def is_unique?(item)
      is_aged_brie?(item) || is_backstage_passes?(item) || is_sulfuras?(item) || is_conjured?(item)
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
      item.quality > MIN_QUALITY_LIMIT && item.quality < MAX_QUALITY_LIMIT
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

    def is_conjured?(item)
      item.name == "Conjured"
    end
end
  