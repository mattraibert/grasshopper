require 'test_helper'
require 'grasshopper/mock'

class MockTest < Minitest::Test
  def test_fails_verify_if_no_such_message
    mock = Grasshopper::Mock.new

    assert_raises Grasshopper::NotSeen do
      Grasshopper::Mock.verify(mock).never_sent
    end
  end

  def test_no_failure_if_message_was_sent
    mock = Grasshopper::Mock.new
    mock.message_was_sent
    Grasshopper::Mock.verify(mock).message_was_sent
  end

  class RespondsToMessageWasSent
    def message_was_sent
      true
    end
  end

  def test_verify_messages_sent_to_mock
    mock = Grasshopper::Mock.new
    mock.message_was_sent
    mock.verify_responds_to_heard_messages(RespondsToMessageWasSent.new)
  end

  def test_verify_unimplemented_messages_explode
    mock = Grasshopper::Mock.new
    mock.message_not_implemented
    assert_raises Grasshopper::NotImplemented do
      mock.verify_responds_to_heard_messages(RespondsToMessageWasSent.new)
    end
  end

  def test_can_verify_number_of_invocations
    mock = Grasshopper::Mock.new
    2.times { mock.message_sent_twice }
    2.times { Grasshopper::Mock.verify(mock).message_sent_twice }
  end

  def test_fails_if_too_few_invocations
    mock = Grasshopper::Mock.new
    mock.message_sent_once

    Grasshopper::Mock.verify(mock).message_sent_once
    assert_raises Grasshopper::NotSeen do
      Grasshopper::Mock.verify(mock).message_sent_once
    end
  end

  def test_validate_param
    mock = Grasshopper::Mock.new
    mock.message_with_param("to verify")
    Grasshopper::Mock.verify(mock).message_with_param("to verify")
  end

  def test_validate_two_params
    mock = Grasshopper::Mock.new
    mock.message_with_params("to", "verify")
    Grasshopper::Mock.verify(mock).message_with_params("to", "verify")
  end

  def test_validate_wrong_param_explodes
    mock = Grasshopper::Mock.new
    mock.message_with_param("param")

    e = assert_raises Grasshopper::NotSeen do
      Grasshopper::Mock.verify(mock).message_with_param("wrong param")
    end

    expected_message = <<-TXT.chomp
Should have seen an invocation of message_with_param(wrong param))

Messages Seen:
message_with_param(param)
    TXT

    assert_equal(expected_message, e.message)
  end

  def test_validate_wrong_number_params_explodes
    mock = Grasshopper::Mock.new
    mock.message_with_param("param", "two")

    assert_raises Grasshopper::NotSeen do
      Grasshopper::Mock.verify(mock).message_with_param("param")
    end
  end

  def test_any_param_matcher_can_stand_in_for_any_param
    mock             = Grasshopper::Mock.new
    mock.value       = "nice value"
    mock.other_value = "other value"
    mock.takes_two(1, 2)
    Grasshopper::Mock.verify(mock).value      = Grasshopper::Mock.any_params
    Grasshopper::Mock.verify(mock).other_value= Grasshopper::Mock.any_params
    Grasshopper::Mock.verify(mock).takes_two Grasshopper::Mock.any_params
  end

  def test_always_returns_nil
    mock = Grasshopper::Mock.new
    assert_nil mock.anything
    assert_nil mock.anything("even with params")
    assert_nil mock.anything(["even with array params"])
  end

  OtherObject = Struct.new(:foo)

  def test_dont_verify_non_mocks
    non_mock = OtherObject.new
    e        = assert_raises RuntimeError do
      Grasshopper::Mock.verify(non_mock)
    end
    assert_equal("Tried to verify a MockTest::OtherObject", e.message)
  end
end
