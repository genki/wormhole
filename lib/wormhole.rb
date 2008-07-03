class Wormhole
  DEFAULT_SYMBOL = :wormhole

  class << self
    def catch(symbol = DEFAULT_SYMBOL, &block)
      result = nil
      wormhole = Kernel.catch(symbol) do
        result = block.call if block
        nil
      end || new
      wormhole.instance_variable_set(:@result, result)
      wormhole
    end

    def throw(*args, &block)
      args.unshift DEFAULT_SYMBOL unless args[0].is_a?(Symbol)
      new.send :connect, *args, &block
    end
  end

  def open(&block)
    return @result if @cc.nil?
    block.call @data if block
    @opened = true
    @cc.call
  end

private
  def connect(symbol, data, &block)
    @data = data
    callcc{|@cc|}
    if @opened
      @result = block.call @data if block
    else
      Kernel.throw symbol, self
    end
  end
end
