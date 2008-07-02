class Wormhole < Exception
  def initialize(data = {})
    @data = data
    callcc{|@cc|}
    raise self unless @return
  end

  def close
    @return = true
    @cc.call
  end

  def [](key) @data[key] end
  def []=(key, value) @data[key] = value end
end
