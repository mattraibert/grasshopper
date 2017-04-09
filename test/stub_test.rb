require 'test_helper'
require 'grasshopper/stub'

class StubTest < MiniTest::Test
  def test_stub_returns_nil
    assert_nil(Grasshopper::Stub.new.unknown_method)
  end

  def test_can_stub_a_method
    stub = Grasshopper::Stub.new
    Grasshopper::Stub.when(stub.this_message).then_return(9)
    assert_equal(9, stub.this_message)
  end

  def test_two_stubs
    stub1 = Grasshopper::Stub.new
    stub2 = Grasshopper::Stub.new
    Grasshopper::Stub.when(stub1.this_message).then_return(9)
    Grasshopper::Stub.when(stub2.that_message).then_return(99)

    assert_nil(stub1.that_message)
    assert_equal(9, stub1.this_message)
    assert_nil(stub2.this_message)
    assert_equal(99, stub2.that_message)
  end

  def test_can_stub_a_method_with_param
    stub = Grasshopper::Stub.new
    Grasshopper::Stub.when(stub.secret(22)).then_return(9)

    assert_nil(stub.secret(21))
    assert_equal(9, stub.secret(22))
  end

  def test_can_stub_two_methods_with_param
    stub = Grasshopper::Stub.new
    Grasshopper::Stub.when(stub.keys).then_return([:door_key, :mail_key])
    Grasshopper::Stub.when(stub.money("gimmie")).then_return(5)

    assert_equal([:door_key, :mail_key], stub.keys)
    assert_equal(5, stub.money("gimmie"))
    assert_nil(stub.monkey)
  end

  def test_another_call_doesnt_confuse
    stub = Grasshopper::Stub.new
    stub.bang
    Grasshopper::Stub.when(stub.bop).then_return("pow")
    assert_equal("pow", stub.bop)
    assert_nil(stub.bang)
  end

  def test_stub_like
    stub = Grasshopper::Stub.like(:zap => "kapow!", :zip => [:one => 1, :two => 2])

    assert_equal("kapow!", stub.zap)
    assert_equal([:one => 1, :two => 2], stub.zip)
    assert_nil(stub.bop)
  end
end
