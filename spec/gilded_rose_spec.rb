require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do

  describe "#update_sell_in" do
    it "should not change the sell_in of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
      gilded_rose = GildedRose.new(items)
      expect { gilded_rose.update_sell_in(items[0]) }.not_to change { items[0].sell_in }
    end

    it "should change the sell_in of non Sulfuras item by -1" do
      items = [Item.new("Aged Brie", 10, 10)]
      gilded_rose = GildedRose.new(items)
      expect{ gilded_rose.update_sell_in(items[0]) }.to change{ items[0].sell_in }.by(-1)
    end
  end

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "does not change the quality of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
      expect { GildedRose.new(items).update_quality() }.not_to change { items[0].quality }
    end
  end

end
