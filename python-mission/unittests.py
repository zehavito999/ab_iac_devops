import pytest
from main import GildedRose, Item, Goods


@pytest.fixture
def gilded_rose():
    items = [
        Item(Goods.DEFAULT.value, 10, 20),
        Item(Goods.DEFAULT.value, 0, 50),
        Item(Goods.AGED_BRIE.value, 5, 10),
        Item(Goods.AGED_BRIE.value, -2, 1),
        Item(Goods.BACKSTAGE_PASSES.value, 15, 20),
        Item(Goods.BACKSTAGE_PASSES.value, 7, 20),
        Item(Goods.BACKSTAGE_PASSES.value, 4, 20),
        Item(Goods.SULFURAS.value, 0, 50),
        Item(Goods.SULFURAS.value, -1, 10),
        Item(Goods.CONJURED.value, 3, 6),
        Item(Goods.CONJURED.value, -1, 0)
    ]
    return GildedRose(items)


def test_update_quality_default_item(gilded_rose):
    # Test that quality and sell_in decrease by 1 for default item
    gilded_rose.update_quality()
    item = gilded_rose.items[0]
    assert item.quality == 19
    assert item.sell_in == 9


def test_update_quality_default_item_twice_as_fast(gilded_rose):
    # Test that quality and sell_in decrease by 2 for default expired item
    gilded_rose.update_quality()
    item = gilded_rose.items[1]
    assert item.quality == 48
    assert item.sell_in == -1


def test_update_quality_aged_brie_item(gilded_rose):
    # Test that quality increases by 1 for Aged Brie item
    gilded_rose.update_quality()
    item = gilded_rose.items[2]
    assert item.quality == 11
    assert item.sell_in == 4


def test_update_quality_expired_aged_brie_item(gilded_rose):
    # Test that quality increases by 1 for expired Aged Brie item
    gilded_rose.update_quality()
    item = gilded_rose.items[3]
    assert item.quality == 2
    assert item.sell_in == -3


def test_update_quality_backstage_passes_item_increased_by_one(gilded_rose):
    # Test that quality increases by 1 for Backstage Passes item depending on sell_in value
    gilded_rose.update_quality()
    item = gilded_rose.items[4]
    assert item.quality == 21
    assert item.sell_in == 14


def test_update_quality_backstage_passes_item_increased_by_two(gilded_rose):
    # Test that quality increases by 2 for Backstage Passes item depending on sell_in value
    gilded_rose.update_quality()
    item = gilded_rose.items[5]
    assert item.quality == 22
    assert item.sell_in == 6


def test_update_quality_backstage_passes_item_increased_by_three(gilded_rose):
    # Test that quality increases by 3 for Backstage Passes item depending on sell_in value
    gilded_rose.update_quality()
    item = gilded_rose.items[6]
    assert item.quality == 23
    assert item.sell_in == 3


def test_update_quality_sulfuras_item(gilded_rose):
    # Test that quality and sell_in do not change for Sulfuras item
    gilded_rose.update_quality()
    item = gilded_rose.items[7]
    assert item.quality == 50
    assert item.sell_in == 0


def test_update_quality_expired_sulfuras_item(gilded_rose):
    # Test that quality and sell_in do not change for Sulfuras expired item
    gilded_rose.update_quality()
    item = gilded_rose.items[8]
    assert item.quality == 10
    assert item.sell_in == -1


def test_update_quality_conjured_item(gilded_rose):
    # Test that quality decreases by 2 for Conjured item
    gilded_rose.update_quality()
    item = gilded_rose.items[9]
    assert item.quality == 4
    assert item.sell_in == 2


def test_update_quality_conjured_item_twice_as_fast(gilded_rose):
    # Test that quality decreases by 4 for expired Conjured item
    gilded_rose.update_quality()
    item = gilded_rose.items[10]
    assert item.quality == 0
    assert item.sell_in == -2

