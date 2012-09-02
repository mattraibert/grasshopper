require 'minitest/unit'

class Mock
  include MiniTest::Assertions

  def verify_next
    @verify_next = true
  end

  def method_missing(message, *args, &block)
    @messages ||= []
    if @verify_next
      index = @messages.index { |item| message == item[0] and item[1] == args }
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

class StubHelper
  def initialize(stub)
    @stub = stub
  end

  def method_missing(sym, *args)
    @message = [sym, args]
    self
  end

  def give_em(retval)
    @stub.add_a_stub(@message, retval)
  end
end

class Stub
  def initialize
    @stubs = {}
  end

  def add_a_stub(message, retval)
    @stubs[message] = retval
  end

  def self.if_you_hear(stub)
    StubHelper.new(stub)
  end

  def method_missing(sym, *args)
    @stubs[[sym, args]]
  end
end