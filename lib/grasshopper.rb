require 'minitest/unit'

class Mock
  def verify_next
    @verify_next = true
  end

  #todo can't figure out how to call assert from here; copying impl
  def assert test, msg = nil
    unless test then
      msg = msg.call if Proc === msg
      raise MiniTest::Assertion, msg
    end
    true
  end

  def method_missing(message, *args, &block)
    @messages ||= []
    if(@verify_next)
      index = @messages.index {|item| message == item[0] and item[1] == args}
      assert(index, "Should have seen an invocation of #{message}")
      @messages.delete_at(index || @messages.length)
    else
      @messages << [message, args]
    end
  end
  
  def self.verify mock
    mock.verify_next
    mock
  end
end
