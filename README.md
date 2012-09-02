# Grasshopper

A tiny mocking framework based on [Mockito](http://code.google.com/p/mockito/)

## Examples

For more examples, see the [unit tests](https://github.com/mattraibert/grasshopper/blob/master/test/grasshopper_test.rb)

### Mock

Mock is a person who listens carefully but never says anything. You say anything to Mock, but you'll only get crickets back.

```ruby
mock = Mock.new
mock.hello                   #=> nil
mock.how_are_you?            #=> nil
Mock.verify(mock).hello      # yes, someone did tell me hello.
Mock.verify(mock).goodbye    # wait(AssertionFailed)! they left without saying goodbye!
```

### Stub

Stub is a person who holds something for you and gives it to anyone who knows how to ask. You can ask Stub for anything, but you'll only get what you put into it.

```ruby
stub = Stub.like(:keys => [:door_key, :mail_key], :money => 5)
stub.keys                    #=> [:door_key, :mail_key]
stub.money("gimmie")         #=> 5
stub.monkeys                 #=> nil
```

## Naming

Grasshopper is named for a [restaurant](http://grasshoppervegan.com/) in Allston, MA that serves up all sorts of great mocks.

## Copyright

Copyright (c) 2011 Matt Raibert.
Grasshopper is available under the GPL v3 see LICENSE.txt for further details.
