require File.dirname(__FILE__) + '/test_helper.rb'
require "test/unit"

class WormholeTest < Test::Unit::TestCase
  def setup
    @result = []
  end

  def foo
    @result << "foo"
    Wormhole.throw :bar => 'hello' do |data|
      @result << data[:bar]
    end
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
    w = Wormhole.catch do
      "test"
    end
    assert_equal "test", w.return
  end

  def test_wormhole_without_symbol
    w = Wormhole.catch do
      @result << "foo"
      Wormhole.throw :bar => 'hello' do |data|
        @result << data[:bar]
      end
      @result << "bar"
      'result'
    end
    result = w.return do |data|
      @result << data[:bar]
      data[:bar] = 'world!'
    end
    assert_equal 'result', result
    assert !@result.empty?
    assert_equal ['foo', 'hello', 'world!', 'bar'], @result
  end
end
