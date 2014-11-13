require 'net/http'
require 'base64'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Qiwi
        # Полезно смотреть тут: https://github.com/Shopify/active_merchant/commit/646919b4016ba75095acb69a029493d1075272ce
        # https://static.qiwi.com/ru/doc/ishop/protocols/Visa_QIWI_Wallet_Pull_Payments_API.pdf
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          attr_accessor :result_code

          def item_id
            # Notifications
            if params.has_key?('bill_id')
              params['bill_id'].to_s.gsub(/\D+/, '')
            # Success redirect
            elsif params.has_key?('order')
              params['order']
            end
          end

          def amount
            BigDecimal.new(gross)
          end

          def gross
            params['amount']
          end

          def amount
            BigDecimal.new(gross)
          end

          def status
            params['status']
          end

          def paid?
            status == 'paid'
          end

          def authorized?(provider, notification_secret, auth_header)
            credentials = Base64.urlsafe_encode64([provider, notification_secret].join(':'))
            auth_header == "Basic #{credentials}"
          end

          def acknowledge(provider, notification_secret, auth_header)
            if paid? && authorized?(provider, notification_secret, auth_header)
              @result_code = 0 # Успех
              true
            else
              false
            end
          end

          def response
            @result_code ||= 151 # Ошибка проверки подписи
            %Q{<?xml version="1.0"?><result><result_code>#{@result_code}</result_code></result>}
          end
        end
      end
    end
  end
end
