require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  def test_foo
    items = [Item.new('foo', 30, 45)]

    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 29
    assert_equal items[0].quality, 44
    assert_equal items[0].name, 'foo'
  end

  def test_once_the_sell_by_date_has_passed_quality_degrades_twice_as_fast
    items = [Item.new('Foo', 1, 50)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 0
    assert_equal items[0].quality, 49
    assert_equal items[0].name, 'Foo'

    items = [Item.new('Foo', 0, 50)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 48
    assert_equal items[0].name, 'Foo'
  end

  def test_the_quality_of_an_item_is_never_negative
    items = [Item.new('Foo', 10, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 0
    assert_equal items[0].name, 'Foo'
  end

  def aged_brie_actually_increases_in_quality_the_older_it_gets
    items = [Item.new('Aged Brie', 10, 0)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 1
    assert_equal items[0].name, 'Aged Brie'
  end

  def the_quality_of_an_item_is_never_more_than_50
    items = [Item.new('Foo', 10, 55)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 50
    assert_equal items[0].name, 'Foo'
  end

  def test_sulfuras
    items = [Item.new('Sulfuras', 10, 80)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 10
    assert_equal items[0].quality, 80
    assert_equal items[0].name, 'Sulfuras'
  end

  def test_backstage_passes_increases_by_2_when_there_are_10_days_or_less
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 30)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 32
    assert_equal items[0].name, 'Backstage passes to a TAFKAL80ETC concert'
  end

  def test_backstage_passes_increases_by_3_when_there_are_3_days_or_less
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 30)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 4
    assert_equal items[0].quality, 33
    assert_equal items[0].name, 'Backstage passes to a TAFKAL80ETC concert'
  end

  def test_backstage_passes_quality_drops_to_zero_after_the_concert
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 30)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 0
    assert_equal items[0].name, 'Backstage passes to a TAFKAL80ETC concert'
  end

  def test_conjured
    items = [Item.new('Conjured', 10, 50)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 48
    assert_equal items[0].name, 'Conjured'

    items = [Item.new('Conjured', -1, 50)]
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -2
    assert_equal items[0].quality, 46
    assert_equal items[0].name, 'Conjured'
  end
end
