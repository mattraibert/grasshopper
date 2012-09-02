require 'test_helper'
require 'grasshopper/stub'

class StubTest < MiniTest::Unit::TestCase
  def test_stub_returns_nil
    assert_nil(Stub.new.unknown_method)
  end

  def test_can_stub_a_method
    stub = Stub.new
    Stub.when(stub.this_message).then_return(9)
    assert_equal(9, stub.this_message)
  end

  def test_two_stubs
    stub1 = Stub.new
    stub2 = Stub.new
    Stub.when(stub1.this_message).then_return(9)
    Stub.when(stub2.that_message).then_return(99)

    assert_equal(nil, stub1.that_message)
    assert_equal(9, stub1.this_message)
    assert_equal(nil, stub2.this_message)
    assert_equal(99, stub2.that_message)
  end

  def test_can_stub_a_method_with_param
    stub = Stub.new
    Stub.when(stub.secret(22)).then_return(9)

    assert_equal(nil, stub.secret(21))
    assert_equal(9, stub.secret(22))
  end

  def test_can_stub_two_methods_with_param
    stub = Stub.new
    Stub.when(stub.keys).then_return([:door_key, :mail_key])
    Stub.when(stub.money("gimmie")).then_return(5)

    assert_equal([:door_key, :mail_key], stub.keys)
    assert_equal(5, stub.money("gimmie"))
    assert_nil(stub.monkey)
  end

  def test_another_call_doesnt_confuse
    stub = Stub.new
    stub.bang
    Stub.when(stub.bop).then_return("pow")
    assert_equal("pow", stub.bop)
    assert_equal(nil, stub.bang)
  end

  def test_stub_like
    stub = Stub.like(:zap => "kapow!", :zip => [:one => 1, :two => 2])

    assert_equal("kapow!", stub.zap)
    assert_equal([:one => 1, :two => 2], stub.zip)
    assert_equal(nil, stub.bop)
  end
end
