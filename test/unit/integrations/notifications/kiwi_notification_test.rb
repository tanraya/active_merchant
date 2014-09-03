require 'test_helper'

class KiwiNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @kiwi = Kiwi::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @kiwi.complete?
    assert_equal "", @kiwi.status
    assert_equal "", @kiwi.transaction_id
    assert_equal "", @kiwi.item_id
    assert_equal "", @kiwi.gross
    assert_equal "", @kiwi.currency
    assert_equal "", @kiwi.received_at
    assert @kiwi.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @kiwi.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @kiwi.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    ""
  end
end
