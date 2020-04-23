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