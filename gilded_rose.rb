class GildedRose
  MIN_QUALITY = 0
  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_sell_in(item)

      case item.name
      when "Sulfuras, Hand of Ragnaros"
      when "Aged Brie"
        item.quality += 1 if item.quality < MAX_QUALITY
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in > 10
          item.quality += 1 if item.quality < MAX_QUALITY
        elsif item.sell_in <= 10 && item.sell_in > 5
          item.quality += 2 if item.quality <= MAX_QUALITY - 2
        elsif item.sell_in <= 5 && item.sell_in >= 0
          item.quality += 3 if item.quality <= MAX_QUALITY - 3
        else
          item.quality = 0
        end
      else
        item.quality -= 1 if item.quality > MIN_QUALITY
      end
    end
  end

  def update_sell_in(item)
    item.sell_in -= 1 if item.name != "Sulfuras, Hand of Ragnaros"
  end
end

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
end