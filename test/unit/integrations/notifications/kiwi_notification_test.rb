require 'test_helper'

class QiwiNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @qiwi = Qiwi::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @qiwi.complete?
    assert_equal "", @qiwi.status
    assert_equal "", @qiwi.transaction_id
    assert_equal "", @qiwi.item_id
    assert_equal "", @qiwi.gross
    assert_equal "", @qiwi.currency
    assert_equal "", @qiwi.received_at
    assert @qiwi.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @qiwi.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @qiwi.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    ""
  end
end
