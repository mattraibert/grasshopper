require 'minitest/autorun'
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
end
