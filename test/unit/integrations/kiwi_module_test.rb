require 'test_helper'

class KiwiModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    assert_instance_of Kiwi::Notification, Kiwi.notification('name=cody')
  end
end
