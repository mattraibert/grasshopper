require 'test_helper'
require 'grasshopper'

class MockTest < MiniTest::Unit::TestCase
  def test_fails_verify_if_no_such_message
    mock = Mock.new

    assert_raises MiniTest::Assertion do
      Mock.verify(mock).never_sent
    end
  end

  def test_no_failure_if_message_was_sent
    mock = Mock.new
    mock.message_was_sent
    Mock.verify(mock).message_was_sent
  end

  def test_can_verify_number_of_invocations
    mock = Mock.new
    2.times { mock.message_sent_twice }
    2.times { Mock.verify(mock).message_sent_twice }
  end

  def test_fails_if_too_few_invocations
    mock = Mock.new
    mock.message_sent_once

    assert_raises MiniTest::Assertion do
      2.times { Mock.verify(mock).message_sent_once }
    end
  end

  def test_validate_param
    mock = Mock.new
    mock.message_with_param("to verify")
    Mock.verify(mock).message_with_param("to verify")
  end

  def test_validate_two_params
    mock = Mock.new
    mock.message_with_params("to", "verify")
    Mock.verify(mock).message_with_params("to", "verify")
  end

  def test_validate_wrong_param_explodes
    mock = Mock.new
    mock.message_with_param("param")

    assert_raises MiniTest::Assertion do
      Mock.verify(mock).message_with_param("wrong param")
    end
  end

  def test_validate_wrong_number_params_explodes
    mock = Mock.new
    mock.message_with_param("param", "two")

    assert_raises MiniTest::Assertion do
      Mock.verify(mock).message_with_param("param")
    end
  end

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
    Stub.when(stub.message).then_return(9)
    Stub.when(stub.secret(22)).then_return("nevar!")

    assert_equal(9, stub.message)
    assert_equal(nil, stub.secret(21))
    assert_equal("nevar!", stub.secret(22))
  end
end
