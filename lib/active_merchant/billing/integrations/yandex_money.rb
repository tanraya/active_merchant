require File.dirname(__FILE__) + '/yandex_money/helper.rb'
require File.dirname(__FILE__) + '/yandex_money/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module YandexMoney

        # Start integration with yandex.money here:
        # https://money.yandex.ru/i/forms/guide-to-custom-p2p-forms.pdf
        def self.service_url
          'https://money.yandex.ru/quickpay/confirm.xml'
        end

        def self.notification(post)
          Notification.new(post)
        end
      end
    end
  end
end
