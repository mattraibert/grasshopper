# frozen_string_literal: true

module Grasshopper
  class Stub
    def initialize
      @stubs = {}
    end

    def add_a_stub(message, retval)
      @stubs[message] = retval
    end

    def self.when(_whatever)
      StubHelper.new(@@stub, @@message)
    end

    def method_missing(sym, *args)
      @@stub = self
      @@message = [sym, args]
      @stubs[[sym, args]]
    end

    def self.like(stubs)
      stub = Stub.new
      stubs.each do |method, retval|
        Stub.when(stub.send(method)).then_return(retval)
      end
      stub
    end
  end

  class StubHelper
    def initialize(stub, message)
      @stub = stub
      @message = message
    end

    def then_return(retval)
      @stub.add_a_stub(@message, retval)
    end
  end
end
