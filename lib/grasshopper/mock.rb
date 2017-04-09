module Grasshopper
  class Mock

    def verify_next
      @verify_next = true
    end

    def method_missing(message, *args, &block)
      @messages ||= []
      if !@verify_next.nil?
        index = @messages.index { |item| message == item[0] and item[1] == args }
        unless index
          raise "Should have seen an invocation of #{message}(#{args.join(", ")})\n#{@messages.inspect}"
        end
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
end
