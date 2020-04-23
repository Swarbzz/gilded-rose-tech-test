require 'item'

class GildedRose

    def initialize(items)
      @items = items
    end
  
    def update_quality()
      @items.each do |item|
        update_sell_in(item, -1) unless is_sulfuras?(item)
        if !is_aged_brie?(item) && !is_backstage_passes?(item) && !is_sulfuras?(item)
          update_quality(item, -1)
        else
          update_quality(item, 1)
          if is_backstage_passes?(item) && item.sell_in < 11
            update_quality(item, 1)
          end
          if is_backstage_passes?(item) && item.sell_in < 6
            update_quality(item, 1)
          end
        end
        if sell_in_passed?(item)
          if !is_aged_brie?(item)
            if !is_backstage_passes?(item) && !is_sulfuras?(item)
              update_quality(item, -1)
            else
              item.quality = item.quality - item.quality
            end
          else
            update_quality(item, 1)
          end
        end
      end
    end

private

  def sell_in_passed?(item)
    item.sell_in < 0
  end

  def update_quality(item, amount)
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
  