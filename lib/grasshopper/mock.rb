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
      assert(index, "Should have seen an invocation of #{message}(#{args.join(", ")})\n#{@messages.inspect}")
      @messages.delete_at(index || @messages.length)
    else
      @messages << [message, args]
    end
    nil
  end

  def self.verify mock
    mock.verify_next
    mock
  end
end
