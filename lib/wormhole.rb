class Wormhole
  VERSION = '0.1.2'
  DEFAULT_NAME = :__wormhole__

  class LateReturnError < SyntaxError
    def initialize
      super "You must call the return method at after the catch block."
    end
  end

  def self.catch(name = DEFAULT_NAME, &block)
    result = nil
    wormhole = Kernel.catch(name) do
      result = block.call if block
      nil
    end || new
    wormhole.instance_variable_set(:@result, result)
    set_trace_func(proc do |event, file, line, id, binding, klass|
      set_trace_func nil or raise LateReturnError if klass != Wormhole
      set_trace_func nil if [event, id] == ['call', :return]
    end)
    wormhole
  end

  def self.throw(*args, &block)
    args.unshift DEFAULT_NAME unless args[0].is_a?(Symbol)
    new.send :connect, *args, &block
  end

  # returns the result of the catch block.
  def return(&block)
    return @result if @cc.nil?
    block.call @data if block
    @opened = true
    @cc.call
  end

private
  def connect(name, data = {}, &block)
    @data = data
    callcc{|@cc|}
    if @opened
      @result = block.call @data if block
      @data
    else
      Kernel.throw name, self
    end
  end
end
