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
        update_aged_brie(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_passes(item)
      when /Conjured/
        update_conjured(item)
      else
        update_normal(item)
      end
    end
  end

  def update_sell_in(item)
    item.sell_in -= 1 unless item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_aged_brie(item)
    change_quality(item, 1)
  end

  def update_backstage_passes(item)
    if item.sell_in > 10
      change_quality(item, 1)
    elsif item.sell_in.between?(6, 10)
      change_quality(item, 2)
    elsif item.sell_in.between?(0, 5)
      change_quality(item, 3)
    else
      item.quality = 0
    end
  end

  def update_conjured(item)
    if item.sell_in >= 0
      change_quality(item, -2)
    else
      change_quality(item, -4)
    end
  end

  def update_normal(item)
    if item.sell_in >= 0
      change_quality(item, -1)
    else
      change_quality(item, -2)
    end
  end

  def change_quality(item, change)
    if change > 0
      item.quality += [change, MAX_QUALITY - item.quality].min
    else
      item.quality -= [change.abs, item.quality - MIN_QUALITY].min
    end
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