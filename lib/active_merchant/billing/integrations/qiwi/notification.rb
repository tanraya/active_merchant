require 'net/http'
require 'base64'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Qiwi
        # Полезно смотреть тут: https://github.com/Shopify/active_merchant/commit/646919b4016ba75095acb69a029493d1075272ce
        # https://static.qiwi.com/ru/doc/ishop/protocols/Visa_QIWI_Wallet_Pull_Payments_API.pdf
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          #def complete?
          #  status == 'paid'
          #end

          def item_id
            params['bill_id'].to_s.gsub(/\D+/, '')
          end

          def amount
            BigDecimal.new(gross)
          end

          #def customer
          #  @options[:customer]
          #end

          # When was this payment received by the client.
          #def received_at
          #  params['']
          #end

          #def payer_email
          #  params['']
          #end

          #def receiver
          #  params['user']
          #end

          #def security_key
          #  params['']
          #end

          def gross
            params['amount']
          end

          def amount
            BigDecimal.new(gross)
          end

          # Was this a test transaction?
          #def test?
          #  false
          #end

          #def status
          #  params['status']
          #end

          # Acknowledge the transaction to Qiwi. This method has to be called after a new
          # apc arrives. Qiwi will verify that all the information we received are correct and will return a
          def acknowledge(provider, notification_secret)
            authorization = Base64.urlsafe_encode64([provider, notification_secret].join(':'))
            uri = URI.parse("https://w.qiwi.com/api/v2/prv/#{provider}/bills/#{item_id}")

            request = Net::HTTP::Get.new(uri.path)

            request['Authorization'] = "Basic #{authorization}"
            request['Accept']        = "text/json"
            request['Content-Type']  = "application/x-www-form-urlencoded; charset=utf-8"

            http             = Net::HTTP.new(uri.host, uri.port)
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE# unless @ssl_strict
            http.use_ssl     = true

            response = http.request(request)
            logger = Logger.new('/home/mmopay/current/log/qiwi.log')
            logger.debug response.inspect
            logger.debug response.body.inspect

            true
            # Replace with the appropriate codes
            #raise StandardError.new("Faulty Qiwi result: #{response.body}") unless ["AUTHORISED", "DECLINED"].include?(response.body)
            #response.body == "AUTHORISED"
          end
        end
      end
    end
  end
end
