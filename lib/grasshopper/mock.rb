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
          raise not_seen_message(request)
        end
        @messages.delete_at(index || @messages.length)
      else
        record_request(request)
      end
      nil
    end

    def not_seen_message(request)
      "Should have seen an invocation of #{request})\n\nMessages Seen:\n#{@messages.map(&:to_s).join("\n")}"
    end

    def record_request(request)
      @messages << request
    end

    MessageHeard = Struct.new(:message, :args) do
      def to_s
        "#{self.message}(#{self.args.join(", ")})"
      end
    end

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
