require 'item'

class GildedRose

    def initialize(items)
      @items = items
    end
  
    def update_quality()
      @items.each do |item|
        item.update_sell_in(-1) unless item.is_sulfuras?
        if !item.is_aged_brie? and !item.is_backstage_passes?
          if !item.is_sulfuras?
            item.update_quality(-1)
          end
        else
          item.update_quality(1)
          if item.is_backstage_passes?
            if item.sell_in < 11
              item.update_quality(1)
            end
            if item.sell_in < 6
              item.update_quality(1)
            end
          end
        end
        if item.sell_in < 0
          if !item.is_aged_brie?
            if !item.is_backstage_passes?
              if !item.is_sulfuras?
                item.update_quality(-1)
              end
            else
              item.quality = item.quality - item.quality
            end
          else
            item.update_quality(1)
          end
        end
      end
    end
  end
  