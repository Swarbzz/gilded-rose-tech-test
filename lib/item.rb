class Item
  attr_accessor :name, :sell_in, :quality
  
  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end
  
  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def update_quality(amount)
    if is_in_quality_range?
      self.quality += amount
    end
  end

  def update_sell_in(amount)
    self.sell_in += amount
  end

  def is_in_quality_range?
    self.quality > 0 && self.quality < 50
  end

  def is_aged_brie?
    self.name == "Aged Brie"
  end

  def is_sulfuras?
    self.name == "Sulfuras, Hand of Ragnaros"
  end

  def is_backstage_passes?
    self.name == "Backstage passes to a TAFKAL80ETC concert"
  end

end