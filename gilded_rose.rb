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
        change_quality(item, 1)
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in > 10
          change_quality(item, 1)
        elsif item.sell_in.between?(6, 10)
          change_quality(item, 2)
        elsif item.sell_in.between?(0, 5)
          change_quality(item, 3)
        else
          item.quality = 0
        end
      when /Conjured/
        if item.sell_in >= 0
          change_quality(item, -2)
        else
          change_quality(item, -4)
        end
      else
        if item.sell_in >= 0
          change_quality(item, -1)
        else
          change_quality(item, -2)
        end
      end
    end
  end

  def change_quality(item, change)
    if change > 0
      item.quality += [change, MAX_QUALITY - item.quality].min
    else
      item.quality -= [change.abs, item.quality - MIN_QUALITY].min
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