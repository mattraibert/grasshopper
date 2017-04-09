module Grasshopper
  class Mock
    def initialize
      @verify_next = false
    end

    def verify_next
      @verify_next = true
    end

    def method_missing(message, *args, &block)
      @messages ||= []
      if @verify_next
        index = @messages.index { |heard| message == heard.message and heard.args == args }
        unless index
          raise "Should have seen an invocation of #{message}(#{args.join(", ")})\n#{@messages.inspect}"
        end
        @messages.delete_at(index || @messages.length)
      else
        @messages << MessageHeard.new(message, args)
      end
      nil
    end

    MessageHeard = Struct.new(:message, :args)

    def self.verify mock
      raise "Not a #{self.class}" unless mock.is_a? Grasshopper::Mock
      mock.verify_next
      mock
    end
    class AnyParam

    end
  end
end
