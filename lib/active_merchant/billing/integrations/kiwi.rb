require File.dirname(__FILE__) + '/kiwi/helper.rb'
require File.dirname(__FILE__) + '/kiwi/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Kiwi

        mattr_accessor :service_url
        self.service_url = 'https://w.qiwi.com/order/external/create.action'

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end
