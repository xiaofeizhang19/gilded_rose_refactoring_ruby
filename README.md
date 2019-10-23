## Introduction

This is a refactoring practice in Ruby for the Gilded Rose kata designed by [Terry Hughes](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/). Legacy code by [Emily Bache](https://github.com/emilybache/GildedRose-Refactoring-Kata).

Here is the text of the kata:

*"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

All items have a SellIn value which denotes the number of days we have to sell the item. All items have a Quality value which denotes how valuable the item is. At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets interesting:

Once the sell by date has passed, Quality degrades twice as fast
The Quality of an item is never negative
“Aged Brie” actually increases in Quality the older it gets
The Quality of an item is never more than 50
“Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
“Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
We have recently signed a supplier of conjured items. This requires an update to our system:

“Conjured” items degrade in Quality twice as fast as normal items.

## Instruction

```
$git clone [repositry]
$cd gilded_rose_refactoring
$bundle install
```
Interact with the code in irb.

To run tests:
```
$rspec
```

## Refactoring Process

Please note that the legacy code has been included in this repository as gilded_rose_legacy_code.rb for reference.  

My refactoring approach as follows:

- Install test suite (RSpec)
- The first thing to be noticed was that the sell_in of 'Sulfuras' does not change with time. All other items' sell_in value decreases everyday. Therefore two tests were written to reflect this.   
Then the method for updating sell_in was added and separated from updating quality.
- The quality of 'Sulfuras' does not change. Test was added and condition was extracted.
- The quality of 'Aged Brie' increases as time passes but should not exceed 50. Tests were added and condition was extracted.
- The quality of 'Backstage passes' is related to its sell_in value. Tests were added and the quality change was handled according to different senario of sell_in value.
- Case conditions were adopted instead of if-elsif for item.name, which offered more concise code.
- Tests for normal items were added to spec. Quality change handling was added to the case conditions.
- Additional requirement from the brief is to update 'Conjured' items. Similar to normal items but with twice of the quality degrade speed, the tests and quality change handling were added.  

- Up to this point the code was already more readable and all tests were passing. While checking edge cases, it was found that some logic operators with combined sell_in value and item quality boundary value resulted in complex if-elsif conditions. Thus changing quality for item was subsquently extracted as a separate method with defined boundaries.

- The final step of the refactoring was to extract updating quality method for each item category respectively.
