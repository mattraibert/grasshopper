# Grasshopper

A tiny mocking framework focused on the [Arrage-Act-Assert](http://c2.com/cgi/wiki?ArrangeActAssert) test pattern. Grasshopper is heavily modeled after [Mockito](http://code.google.com/p/mockito/).

## Examples

For more examples, see the [unit tests](https://github.com/mattraibert/grasshopper/blob/master/test/grasshopper_test.rb)

### Mock

Mock is a person who listens carefully but never says anything. You can say anything to Mock, but you'll only get crickets back.

```ruby
mock = Grasshopper::Mock.new
mock.hello                   #=> nil
mock.how_are_you?            #=> nil
Grasshopper::Mock.verify(mock).hello      # yes, someone did tell me hello.
Grasshopper::Mock.verify(mock).goodbye    # wait(AssertionFailed)! they left without saying goodbye!
```

### Stub

Stub is a person who holds something for you and gives it to anyone who knows how to ask. You can ask Stub for anything, but you'll only get out what you put into it.

```ruby
stub = Grasshopper::Stub.new
Grasshopper::Stub.when(stub.keys).then_return([:door_key, :mail_key])
Grasshopper::Stub.when(stub.money("gimmie")).then_return(5)
stub.keys                    #=> [:door_key, :mail_key]
stub.money("gimmie")         #=> 5
stub.monkey                  #=> nil
```

or you can use this shorter style if you prefer:

```ruby
Grasshopper::Stub.like(:keys => [:door_key, :mail_key], :money => 5)
stub.keys                    #=> [:door_key, :mail_key]
stub.money("gimmie")         #=> 5
stub.monkey                  #=> nil
```

## Naming

Grasshopper is named for a [restaurant](http://grasshoppervegan.com/) in Allston, MA that serves up all sorts of great mocks.

## Copyright

Copyright 2011-2017 Position Development, LLC.

Grasshopper is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Grasshopper is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with Grasshopper. If not, see http://www.gnu.org/licenses/.