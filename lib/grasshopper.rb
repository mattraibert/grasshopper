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
      assert(@messages.include?(message), "Should have seen an invocation of #{message}")
      @messages.delete_at(@messages.index(message) || @messages.length)
    else
      @messages << message
    end
  end
  
  def self.verify mock
    mock.verify_next
    mock
  end
end
