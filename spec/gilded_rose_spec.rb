require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do
  def init_gilded_rose(items)
    @gilded_rose = GildedRose.new(items)
  end

  describe "#update_sell_in" do
    it "should not change the sell_in of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
      init_gilded_rose(items)
      expect { @gilded_rose.update_sell_in(items[0]) }.not_to change { items[0].sell_in }
    end

    it "should change the sell_in of non Sulfuras item by -1" do
      items = [Item.new("Aged Brie", 10, 10)]
      init_gilded_rose(items)
      expect{ @gilded_rose.update_sell_in(items[0]) }.to change{ items[0].sell_in }.by(-1)
    end
  end

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      init_gilded_rose(items)
      @gilded_rose.update_quality()
      expect(items[0].name).to eq "foo"
    end

    describe "Sulfuras" do
      it "does not change the quality of Sulfuras" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.not_to change { items[0].quality }
      end
    end

    describe "general items" do
      it "should change the quality of general item by -1 before sell_in date" do
        items = [Item.new("foo", 10, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change{ items[0].quality }.by(-1)
      end
  
      it "should change the quality of general item by -2 after sell_in date" do
        items = [Item.new("foo", -1, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change{ items[0].quality }.by(-2)
      end
  
      it "should not change the quality of general item to below 0" do
        items = [Item.new("foo", 10, 0)]
        init_gilded_rose(items)
        @gilded_rose.update_quality()
        expect(items[0].quality).to eq(0)
      end
    end

    describe 'Aged Brie' do
      it "should increase the quality of Aged Brie by 1" do
        items = [Item.new("Aged Brie", 10, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change{ items[0].quality }.by(1)
      end
  
      it "should not increase the quality of Aged Brie to above 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        init_gilded_rose(items)
        @gilded_rose.update_quality()
        expect(items[0].quality).to eq(50)
      end
    end

    describe "Backstage Pass" do
      it "should increase the quality of Backstage Pass by 1 when sell_in is greater than 10" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change{ items[0].quality }.by(1)
      end
  
      it "should increase the quality of Backstage Pass by 2 when sell_in is 6 to 10" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change{ items[0].quality }.by(2)
      end
  
      it "should increase the quality of Backstage Pass by 3 when sell_in is 0 to 5" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change{ items[0].quality }.by(3)
      end

      it "should not increase the quality of Backstage Pass to above 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)]
        init_gilded_rose(items)
        @gilded_rose.update_quality()
        expect(items[0].quality).to eq(50)
      end
  
      it "should set the quality of Backstage Pass to 0 when sell_in is less than 0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
        init_gilded_rose(items)
        @gilded_rose.update_quality()
        expect(items[0].quality).to eq(0)
      end
  
      it "should not increase the quality of Backstage Pass to more than 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)]
        init_gilded_rose(items)
        @gilded_rose.update_quality()
        expect(items[0].quality).to eq(50)
      end
    end

    describe "Conjured items" do
      it "Should change the quality by -2 before sell_in date" do
        items = [Item.new("Conjured banana", 10, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change { items[0].quality }.by(-2)
      end

      it "Should change the quality by -4 after sell_in date" do
        items = [Item.new("Conjured banana", -1, 10)]
        init_gilded_rose(items)
        expect { @gilded_rose.update_quality() }.to change { items[0].quality }.by(-4)
      end

      it "Should not change the quality to below 0" do
        items = [Item.new("Conjured banana", -1, 2)]
        init_gilded_rose(items)
        @gilded_rose.update_quality()
        expect(items[0].quality).to eq(0)
      end
    end
  end
end
