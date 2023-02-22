#!/usr/bin/env python3.8
from enum import Enum

"""
How system works:
* Default items (everything but Aged Brie, Backstage passes, Sulfuras, Conjured) quality degrades by 1 each passed day.
* Once an item sell_in date has passed, the quality degrades twice as fast, therefore quality degrades by 2 per day.
* Aged Brie increases in quality the older it gets, therefore quality increased by 1 per day.
* Backstage passes increase in quality as the sellin date approaches:
    if there are days > 10 left, they increased by 1 per day.
    if there are 6 <= days <= 10, they increased by 2 per day.
    if there are days <= 5, they increased by 3 per day.
    After the sell_in date, their quality drops to 0.
* Sulfuras is a legendary item that never has to be sold and never decreases in quality.
* Conjured items degrade in quality twice as fast as normal items, so their quality decreases by 2 per day.
"""


class Goods(Enum):
    DEFAULT = "default"
    AGED_BRIE = "Aged Brie"
    BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
    SULFURAS = "Sulfuras, Hand of Ragnaros"
    CONJURED = "Conjured"


class GildedRose(object):
    def __init__(self, items):
        self.items = items

    def update_quality(self):
        for item in self.items:
            if item.name == Goods.SULFURAS.value:
                continue
            if item.name == Goods.AGED_BRIE.value:
                item.quality = min(item.quality + 1, 50)
            elif item.name == Goods.BACKSTAGE_PASSES.value:
                if item.sell_in <= 0:
                    item.quality = 0
                elif item.sell_in <= 5:
                    item.quality = min(item.quality + 3, 50)
                elif item.sell_in <= 10:
                    item.quality = min(item.quality + 2, 50)
                else:
                    item.quality = min(item.quality + 1, 50)
            else:
                expired = item.sell_in <= 0
                rate = 2 if item.name == Goods.CONJURED.value else 1
                item.quality = max(item.quality - 2 * rate, 0) if expired else max(item.quality - rate, 0)
            item.sell_in -= 1


class Item:
    def __init__(self, name: str, sell_in: int, quality: int):
        """
        :param name: item name
        :param sell_in: denotes the number of days item must be sell
        :param quality: denotes how valuable the item is
        """
        self.name = name
        self.sell_in = sell_in
        self.quality = quality

    def __repr__(self):
        return f"{self.name}, {self.sell_in}, {self.quality}"
