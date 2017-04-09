module Grasshopper
  class Mock
    def initialize
      @verify_next = false
    end

    def verify_next
      @verify_next = true
    end

    def method_missing(message, *args, &block)
      request = MessageHeard.new(message, args)

      @messages ||= []
      if @verify_next
        if args.first.is_a? AnyParams
          index = @messages.index { |heard| request.message == heard.message }
        else
          index = @messages.index { |heard| request == heard }
        end
        if index.nil?
          raise "Should have seen an invocation of #{message}(#{args.join(", ")})\n#{@messages.inspect}"
        end
        @messages.delete_at(index || @messages.length)
      else
        @messages << request
      end
      nil
    end

    MessageHeard = Struct.new(:message, :args)

    def self.verify mock
      raise "Not a #{self.class}" unless mock.is_a? Grasshopper::Mock
      mock.verify_next
      mock
    end

    def self.any_params
      Grasshopper::Mock::AnyParams.new
    end

    class AnyParams
    end
  end
end
