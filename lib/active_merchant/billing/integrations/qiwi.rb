require File.dirname(__FILE__) + '/qiwi/helper.rb'
require File.dirname(__FILE__) + '/qiwi/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Qiwi

        mattr_accessor :service_url
        self.service_url = 'https://w.qiwi.com/order/external/create.action'

        def self.helper(order, account, options = {})
          Helper.new(order, account, options)
        end

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end
