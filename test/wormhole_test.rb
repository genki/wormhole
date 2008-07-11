require File.dirname(__FILE__) + '/test_helper.rb'
require "test/unit"

class WormholeTest < Test::Unit::TestCase
  def setup
    @result = []
  end

  def foo
    @result << "foo"
    data = Wormhole.throw :bar => 'hello'
    @result << data[:bar]
    @result << "bar"
  end

  def test_wormhole
    Wormhole.catch do
      foo
    end.return do |data|
      @result << data[:bar]
      data[:bar] = 'world!'
    end
    assert !@result.empty?
    assert_equal ['foo', 'hello', 'world!', 'bar'], @result
  end

  def test_wormhole_without_throw
    result = Wormhole.catch do
      "test"
    end.return
    assert_equal "test", result
  end

  def test_nested_wormhole
    array = []
    result = Wormhole.catch(:foo) do
      Wormhole.catch(:bar) do
        Wormhole.throw :foo, 1
        Wormhole.throw :bar, 2
        "test"
      end.return do |value|
        array << value
      end
    end.return do |value|
      array << value
    end
    assert_equal [1, 2], array
    assert_equal 'test', result
  end

  def test_wormhole_without_trailing_return
    assert_raise Wormhole::LateReturnError do
      w = Wormhole.catch do
        "test"
      end
      w.return
    end
  end

  def test_wormhole_without_symbol
    result = Wormhole.catch do
      @result << "foo"
      Wormhole.throw :bar => 'hello' do |data|
        @result << data[:bar]
      end
      @result << "bar"
      'result'
    end.return do |data|
      @result << data[:bar]
      data[:bar] = 'world!'
    end
    assert_equal 'result', result
    assert !@result.empty?
    assert_equal ['foo', 'hello', 'world!', 'bar'], @result
  end
end
