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

      @requests ||= []
      if @verify_next
        if args.first.is_a? AnyParams
          index = @requests.index { |heard| request.message == heard.message }
        else
          index = @requests.index { |heard| request == heard }
        end
        if index.nil?
          raise not_seen_exception(request)
        end
        @requests.delete_at(index || @requests.length)
      else
        record_request(request)
      end
      nil
    end

    def not_seen_exception(request)
      NotSeen.new("Should have seen an invocation of #{request})\n\nMessages Seen:\n#{@requests.map(&:to_s).join("\n")}")
    end

    def record_request(request)
      @requests << request
    end

    def verify_responds_to_heard_messages(instance)
      @requests.each do |request|
        raise NotImplemented.new(request) unless instance.respond_to?(request.message)
      end
    end

    MessageHeard = Struct.new(:message, :args) do
      def to_s
        "#{self.message}(#{self.args.join(", ")})"
      end
    end

    def self.verify mock
      raise "Tried to verify a #{mock.class}" unless mock.is_a? Grasshopper::Mock
      mock.verify_next
      mock
    end

    def self.any_params
      Grasshopper::Mock::AnyParams.new
    end

    class AnyParams
    end
  end

  class NotSeen < ::Exception
  end

  class NotImplemented < ::Exception
  end
end
