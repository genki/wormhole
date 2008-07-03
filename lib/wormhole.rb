class Wormhole
  def self.catch(&block)
    result = nil
    wormhole = Kernel.catch(:__wormhole__) do
      result = block.call if block
      nil
    end || new
    wormhole.instance_variable_set(:@result, result)
    wormhole
  end

  def self.throw(data = {}, &block)
    new.send :connect, data, &block
  end

  # returns the result of the catch block.
  def return(&block)
    return @result if @cc.nil?
    block.call @data if block
    @opened = true
    @cc.call
  end

private
  def connect(data, &block)
    @data = data
    callcc{|@cc|}
    if @opened
      @result = block.call @data if block
    else
      Kernel.throw :__wormhole__, self
    end
  end
end
