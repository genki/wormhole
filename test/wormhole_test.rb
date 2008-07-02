require File.dirname(__FILE__) + '/test_helper.rb'
require "test/unit"

class WormholeTest < Test::Unit::TestCase
  def setup
    @result = []
  end

  def foo
    @result << "foo"
    w = Wormhole.new :foo => 'hello'
    @result << w[:foo]
    @result << "bar"
  end

  def test_wormhole
    foo
    assert !@result.empty?
    assert_equal [
      'foo',
      'hello',
      'world!',
      'bar',
      ], @result
  rescue Wormhole => w
    @result << w[:foo]
    w[:foo] = 'world!'
    w.close
  end
end
